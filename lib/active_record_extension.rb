require 'active_support/concern'

module ActiveRecordExtension

  extend ActiveSupport::Concern

  def jobs
    Delayed::Job.where(owner_id: self.id, owner_type: self.class.name)
  end

  def send_at(time, method, priority = 1, *args)
    Delayed::Job.transaction do
      job = Delayed::Job.enqueue(Delayed::PerformableMethod.new(self, 
            method.to_sym, args), priority, time)
      job.owner_id = self.id
      job.owner_type = self.class.name
      job.queue = "#{self.class.name}_#{method.to_s}"
      job.save!
    end
  end

  # add your static(class) methods here
  class_methods do

  end
end

# include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtension)