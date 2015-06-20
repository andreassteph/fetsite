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
        lflag=("flag_"+params[:flag]).to_sym
        unless params[:flag].nil? || params[:flag].empty? || params[:value].nil?
          @obj.try(lflag)#=params[:value]
          @obj.send(lflag.to_s+"=",params[:value])
        end
        respond_to do |format|
          format.html {render :text=>@obj.to_yaml}
          format.js {render :text => "alert(#{lflag.to_s} #{@obj.to_yaml})"}
        end
      end
    end
  end
end


