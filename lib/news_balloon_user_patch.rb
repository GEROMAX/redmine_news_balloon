require_dependency("user")

module NewsBalloonUserPatch
  def self.included(base)
    base.send(:include, InstanceMethod)

    base.class_eval do
      # アクセス日時
      attr_accessor :last_before_access_on
    end
  end
  
  module InstanceMethod

  end

end

User.send(:include, NewsBalloonUserPatch)
