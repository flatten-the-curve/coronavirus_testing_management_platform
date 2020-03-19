ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: "Dashboard"

  content title: "All Testing Sites" do
    vars = request.query_parameters

    host_id = vars["host_id"]
    if host_id == ""
      host_id = nil
    end

    all_lines = sum_all_lines(host_id)
    all_patients = sum_all_patients(host_id)
    avg_time = calculate_average_times(host_id)

    render partial: "graph", locals: {lines: all_lines, patients: all_patients, hosts: Host.all, time: avg_time, host_id: host_id}

    table_for Host.all do
      column(:name) do |host|
        "<a target='_blank' href='#{admin_host_path(host)}'>#{host.name}</a>".html_safe
      end
      column :address_1
      column :address_2
      column :city
      column :state
      column :zipcode
      column "Patients Tested Today", :patient_count_today
      column "Current Line Count", :line_count_today
    end
  end
end

def sum_all_lines(host_id = nil)
  line_counts = LineCount.where(created_at: [Time.current.beginning_of_day..Time.current.end_of_day])
  line_counts = line_counts.where(host_id: host_id) if host_id
  line_counts.sum(:amount)
end

def sum_all_patients(host_id = nil)
  patient_counts = PatientCount.where(created_at: [Time.current.beginning_of_day..Time.current.end_of_day])
  patient_counts = patient_counts.where(host_id: host_id) if host_id
  patient_counts.sum(:amount)
end

def calculate_average_times(host_id = nil)
  host_times = {}
  averages = []

  hosts = Host.all
  hosts = hosts.where(id: host_id) if host_id

  patient_counts = PatientCount.where(host_id: hosts).where(created_at: [Time.current.beginning_of_day..Time.current.end_of_day]).order("created_at")

  patient_counts.each do |patient|
    unless host_times.key?(patient.host_id)
      host_times[patient.host_id] = {
        last_time: patient.created_at,
        times: [],
        average: nil
      }
      next
    end

    last_time = host_times[patient.host_id][:last_time]
    diff = ((patient.created_at - last_time) / 60).round(2)
    host_times[patient.host_id][:times].push(diff)
    host_times[patient.host_id][:last_time] = patient.created_at
    logger.info "Last Time: " + last_time.to_s(:rfc822)
  end

  host_times.select { |k, v| v[:times].count > 0 }.each do |host_id, host_data|
    average = (host_times[host_id][:times].inject { |sum, el| sum + el }.to_f / host_times[host_id][:times].size).round(2)
    host_times[host_id][:average] = average
    averages.push(average)
  end

  return "N/A" if averages.size == 0

  (averages.inject { |sum, el| sum + el }.to_f / averages.size).round(2)
end
