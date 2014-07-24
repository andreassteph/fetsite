module LikeVoteable  
  def self.included(base)
    base.class_eval do
      include InstanceMethods
      #base.hidden_actions.delete 'like'
    end
  end
  module InstanceMethods  
    def like
      @obj=controller_name.classify.constantize.find(params[:id])
      if current_user.liked? @obj
        @obj.unliked_by current_user
      else
        @obj.liked_by current_user
      end
      redirect_to @obj 
    end
    def dislike
      @obj=controller_name.classify.constantize.find(params[:id])
      if current_user.disliked?(@obj)
        @obj.undisliked_by current_user
      else
        @obj.disliked_by current_user
      end
      redirect_to @obj 
    end

  end
end
