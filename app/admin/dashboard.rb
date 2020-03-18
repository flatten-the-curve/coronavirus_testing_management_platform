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
      column(:name) { |host| 
        "<a target='_blank' href='#{admin_host_path(host)}'>#{host.name}</a>".html_safe
      }
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
    @lineQuery = LineCount.where(created_at: [Time.now.beginning_of_day..Time.now.end_of_day])
    if (host_id)
        @lineQuery = @lineQuery.where(host_id: host_id)
    end
    return @lineQuery.sum(:amount)
end

def getAllPatients(host_id=nil)
    @patientQuery = PatientCount.where(created_at: [Time.now.beginning_of_day..Time.now.end_of_day])
    if (host_id)
        @patientQuery = @patientQuery.where(host_id: host_id)
    end
    return @patientQuery.sum(:amount)
end


def getAverageTimes(host_id=nil)
   @hostTimes = Array.new
   if (host_id)
    @query = Host.where(id: host_id)
   else
     @query = Host.all
   end
   @query.each do |host|
       @lastTime =  nil
       @times = Array.new
       @patientQuery = PatientCount.where(host_id: host.id).where(created_at: [Time.now.beginning_of_day..Time.now.end_of_day]).order('created_at')
       @patientQuery.each do |patient|
            if ( !@lastTime )
                @lastTime = patient.created_at
                next
            end
            @diff = ((patient.created_at - @lastTime) / 60).round(2)
            @times.push(@diff)
            @lastTime = patient.created_at
       end

       @hostTimes.push( (@times.inject{ |sum, el| sum + el }.to_f / @times.size).round(2) )
   end

   return (@hostTimes.inject{ |sum, el| sum + el }.to_f / @hostTimes.size).round(2)
end
