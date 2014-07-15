# -*- coding: utf-8 -*-
class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # Rechteverwaltung fuer Studien Modul
    can [:show, :index], Studium
    can [:show, :index], Modulgruppe
    can [:show, :index], Modul
    can [:show, :index], Lva
    can [:create, :show], Beispiel

    can [:show,:index], Gallery
    can [:show, :index,:faqs], Themengruppe
    can [:show], Thema, :isdraft=>false

    can [:show, :index], Fetprofile
    can [:show, :index],Gremium

    # Rechteverwaltung Kalender 
    can [:show, :index], Calendar, :public => true 
    can [:showics], Calendar
    can [:show], Calentry

    if( user.has_role?("fetuser") || user.has_role?("fetadmin"))
      can :manage,:all
      can :manage, Modulgruppe
      can :showdraft , Thema
      can :showintern, Thema
      can :showintern, Neuigkeit
      can :showintern, Rubrik
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
     end
    # Rechteverwaltung fuer Neuigkeiten

#    can :write, Neuigkeit if user.has_role?("newsmoderator", Neuigkeit.rubrik)

   if user.has_role?("newsadmin") || user.has_role?("fetadmin") 
      can :addmoderator, Rubrik
   end    
    can [:show,:index], Rubrik, :public=>true
  
    can :show, Neuigkeit, :rubrik=>{:public=>true}
    if user.has_role?("fetadmin")
      can :addfetuser, User
      can :addfetadmin, User
    end
   
   if user.has_role?("newsadmin") || user.has_role?( "fetadmin") || user.has_role?( "fetuser") 
	  can :manage, Rubrik
	  can :manage, Neuigkeit
          can :shownonpublic, Rubrik
          can :showunpublished, Neuigkeit
     can :seeintern, User
    
   end
  
  
  end
end
