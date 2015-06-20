module Flagable
  module ActsAsFlagableController
    extend ActiveSupport::Concern
    included do

    end
    module ClassMethods
      def acts_as_flagable(options={})
        include Flagable::ActsAsFlagableController::LocalInstanceMethods
        #extend class methods
      end
    end
    module LocalInstanceMethods
      def flag
         @obj=controller_name.classify.constantize.find(params[:id])
        lflag=("flag_"+params[:flag]).to_sym
        unless params[:flag].nil? || params[:flag].empty? || params[:value].nil?
          if @obj.respond_to?(lflag.to_s+"=")
          @obj.send(lflag.to_s+"=",params[:value])
          end
        end
        respond_to do |format|
          format.html {render :text=>@obj.to_yaml}
          format.js {render :text => "$(\"#{@obj.flaglinkid(params[:flag])}\").replaceWith("+ActionController::Base.helpers.escape_javascript(ActionController::Base.helpers.flag_link(@obj,params[:flag],ActionController::Base.helpers.content_tag("i", "", class:"fa fa-flag")))+ "); alert('#{lflag.to_s} #{ ActionController::Base.helpers.escape_javascript(@obj.to_yaml.to_s)}');"}
        end
      end
    end
  end

  module ActsAsFlagableRecord
    extend ActiveSupport::Concern
    included do

    end
    module ClassMethods
      def acts_as_flagable(options={})
        include Flagable::ActsAsFlagableRecord::LocalInstanceMethods
        #extend class methods
      end
    end
    module LocalInstanceMethods
      def get_flag(flag)
        v= @obj.send("flag_"+flag.to_s) if @obj.respond_to?("flag_"+flag.to_s)
        v= false if v.nil?
        v
      end
      def flaglinkid(flag)
        return self.class.to_s + "_" + self.id.to_s + "_flag_"+flag.to_s
      end
    end
  end
  module FlagableHelper

    def flag_link(obj, flag, text)
      value=obj.get_flag(flag)
      color=(value) ? "red" :"grey"
link_to text, Rails.application.routes.url_helpers.flag_beispiel_path(obj,{flag: flag, value: !value, theme: nil, locale: nil}), remote: true, style:("color:" +color ), id: obj.flaglinkid(flag)
    end
  end
end
ActionView::Base.send :include, Flagable::FlagableHelper
