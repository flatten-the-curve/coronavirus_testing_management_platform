ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: "Dashboard"


  content title: "All Testing Sites" do

    vars = request.query_parameters

      @host_id = vars['host_id']
      if ( @host_id == '' )
          @host_id = nil
      end

      @all_lines = getAllLines(@host_id)
      @all_patients = getAllPatients(@host_id)
      @avg_time = getAverageTimes(@host_id)

      render partial: 'graph', locals: { lines: @all_lines, patients: @all_patients, hosts: Host.all, time: @avg_time, host_id: @host_id }

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

def getAllLines(host_id=nil)
    lineQuery = LineCount.where(created_at: [Time.current.beginning_of_day..Time.current.end_of_day])
    lineQuery = lineQuery.where(host_id: host_id)if host_id
    lineQuery.sum(:amount)
end

def getAllPatients(host_id=nil)
    patientQuery = PatientCount.where(created_at: [Time.current.beginning_of_day..Time.current.end_of_day])
    patientQuery = patientQuery.where(host_id: host_id) if host_id
    patientQuery.sum(:amount)
end


def getAverageTimes(host_id=nil)
    hostTimes = {}
    averages = Array.new

    hosts = Host.all
    hosts = hosts.where(id: host_id) if host_id

    patientQuery = PatientCount.where(host_id: hosts).where(created_at: [Time.current.beginning_of_day..Time.current.end_of_day]).order('created_at')

    patientQuery.each do |patient|
        if !hostTimes.has_key?(patient.host_id)
            hostTimes[patient.host_id] = {
                "lastTime" => patient.created_at,
                "times" => Array.new,
                "average" => nil
            }
            next
        end

        lastTime = hostTimes[patient.host_id]["lastTime"]
        diff = ((patient.created_at - lastTime) / 60).round(2)
        hostTimes[patient.host_id]["times"].push(diff)
        hostTimes[patient.host_id]["lastTime"] = patient.created_at
        logger.info "Last Time: " + lastTime.to_s(:rfc822)
    end

    hostTimes.select{|k,v| v["times"].count > 0 }.each { |host_id, host_data|
        average = (hostTimes[host_id]["times"].inject{ |sum, el| sum + el }.to_f / hostTimes[host_id]["times"].size).round(2)
        hostTimes[host_id]["average"] = average
        averages.push(average)
    }

    (averages.inject{ |sum, el| sum + el }.to_f / averages.size).round(2)
end
