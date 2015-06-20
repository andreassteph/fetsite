module Flagable
  module ActsAsFlagable
    extend ActiveSupport::Concern
    included do

    end
    module ClassMethods
      def acts_as_flagable(options={})
        include Flagable::ActsAsFlagable::LocalInstanceMethods
        #extend class methods
      end
    end
    module LocalInstanceMethods
      def flag
         @obj=controller_name.classify.constantize.find(params[:id])
        text @obj.to_yaml
      end
    end
  end
end
ActionController::Base.send :include, Flagable::ActsAsFlagable
ActionController.send :include, Flagable::ActsAsFlagable

ApplicationController.send :include, Flagable::ActsAsFlagable
BeispielController.send :include, Flagable::ActsAsFlagable
