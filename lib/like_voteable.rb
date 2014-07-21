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
      @obj.liked_by current_user
      redirect_to @obj 
    end
    def dislike
      @obj=controller_name.classify.constantize.find(params[:id])
      @obj.disliked_by current_user
      redirect_to @obj 
    end

  end
end
