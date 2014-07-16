# -*- coding: utf-8 -*-
class Ability
  include CanCan::Ability
  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilitiescan :manage, :all
    
    user ||= User.new # guest user (not logged in)
    
    
    # For Debug allow everything
    # Remove this line in production environment and for testing user management
#    can :manage, :all     
    can :addfetuser, User
    can :addfetadmin, User

    can [:show, :index], Studium
    can [:show, :index], Modulgruppe
    can [:show, :index], Modul
    can [:show, :index], Lva
    can [:show,:index], Gallery
    can [:show, :index,:faqs], Themengruppe
    can [:show], Thema, :isdraft=>false
    can [:create], Beispiel
    can [:show, :index], Fetprofile
    can [:show, :index],Gremium
    # Rechteverwaltung fuer Studien Modul
  
    

    # Rechteverwaltung Kalender 
    can [:show, :index], Calendar, :public => true 
    can [:showics], Calendar
    can [:show], Calentry
    if( user.has_role?("fetuser") || user.has_role?("fetadmin"))
      can :manage,:all
      can :manage, Modulgruppe
      can :showdraft , Thema
      can [:show,:index], Calendar
      can  [:edit, :update,:new,:create,:verwalten], Calendar
      can  [:edit, :update,:new,:create,:verwalten], Calentry
    end
    if( user.has_role?("fetadmin"))
      can [:delete],Calendar
      can [:delete],Calentry
      can :doadmin, User
    end
    unless user.has_role?("fetadmin")
      cannot :delete, Modulgruppe
      cannot :delete, Rubrik
      cannot :delete, Themengruppe
      cannot :delete, Fetprofile
      cannot :delete, Studium
      cannot :delete, Modul
      cannot :delete ,Gremium
     end
    # Rechteverwaltung fuer Neuigkeiten

#    can :write, Neuigkeit if user.has_role?("newsmoderator", Neuigkeit.rubrik)

   if user.has_role?("newsadmin") || user.has_role?("fetadmin") 
      can :addmoderator, Rubrik
   end    
    can [:show,:index], Rubrik, :public=>true
  
    can :show, Neuigkeit, :rubrik=>{:public=>true}
   
   if user.has_role?("newsadmin") || user.has_role?( "fetadmin") || user.has_role?( "fetuser") 
	  can :manage, Rubrik
	  can :manage, Neuigkeit
          can :shownonpublic, Rubrik
          can :showunpublished, Neuigkeit
     can :seeintern, User
    
   end
  
  
  end
end
