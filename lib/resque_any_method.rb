require "resque_any_method/version"
require 'resque'

module ResqueAnyMethod
    def self.included(base)
    base.extend(ClassMethods)    
  end

  module ClassMethods
    def resque_queue(queue='low')
      class_eval %(
        @queue = :#{queue}
      )
    end

    def inherited(subclass)
      super
      subclass.instance_variable_set("@queue", @queue)
    end

    def perform(id, method, *args)
      if id.nil?
        self.send(method, *args)
      else
        find(id).send(method, *args)
      end
    end

    def resque_method(method, *args)
      if (Rails.env.test? or Rails.env.development?) and !ENV["WITH_RESQUE"]
        self.send(method, *args)
      else
        Resque.enqueue(self, nil, method, *args)
      end
    end
  end

  # We can pass this any Repository instance method that we want to
  # run later.
  def resque_method(method, *args)
    if (Rails.env.test? or Rails.env.development?) and !ENV["WITH_RESQUE"]
      self.send(method, *args)
    else
      Resque.enqueue(self.class, id, method, *args)
    end
  end
end
