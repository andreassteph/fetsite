# -*- coding: utf-8 -*-
class Ability
  include CanCan::Ability
  def initialize(user)
    loggedin=!(user.nil?)
    user ||= User.new # guest user (not logged in)

    
    #-----------------------------------------------------
    # Rechteverwaltung fuer Studien Modul
    can [:show, :index], Studium
    can [:show], Modulgruppe
    can [:show, :index], Modul
    can [:show, :index, :beispiel_sammlung], Lva
    can [:create, :show], Beispiel
    if loggedin
      can :like, Beispiel
      can :dislike, Beispiel
    end
    if( user.has_role?("fetuser") || user.has_role?("fetadmin"))
      can :manage, Modulgruppe
      can :manage, Modul
      can :manage, Lva
      can :manage, Studium
      can :manage, Beispiel
      can :manage, Lecturer
      
    end
    unless user.has_role?("fetadmin")
      cannot :delete, Studium    
      cannot :delete, Modulgruppe
      cannot :delete, Modul
    end

    #-----------------------------------------------------
    # Rechteverwaltung fuer Informationen
    can [:show, :index,:faqs], Themengruppe, :public=>true  
    can [:show], Thema, :isdraft=>false,  :themengruppe=>{:public=>true}
    can :show, Frage
    if loggedin
    end
    if( user.has_role?("fetuser") || user.has_role?("fetadmin"))
      can :manage, Frage
      can :showdraft , Thema
      can :showintern, Thema
      can :manage, Thema
      can :manage, Themengruppe
      can :manage, Attachment
    end
    unless user.has_role?("fetadmin")
      cannot :delete, Themengruppe
      cannot :delete, Thema
    end

    #-----------------------------------------------------
    # Rechteverwaltung fuer Fotos

#    can [:show,:index], Gallery, :intern=>false
    if loggedin
    end
    if( user.has_role?("fetuser") || user.has_role?("fetadmin"))
      can :manage, Gallery
    end
    unless user.has_role?("fetadmin")
      cannot :delete, Gallery
    end
    
    #-----------------------------------------------------
    # Rechteverwaltung fuer Mitarbeiter
    can [:show, :index], Fetprofile
    can [:show, :index],Gremium
    if loggedin
    end
    if( user.has_role?("fetuser") || user.has_role?("fetadmin"))
      can :manage, Fetprofile
      can :manage, Gremium
      can :manage, Membership
    end
    unless user.has_role?("fetadmin")
      cannot :delete, Fetprofile
      cannot :delete ,Gremium
    end
    
    #-----------------------------------------------------
    # Rechteverwaltung fuer Neuigkeiten
    can [:show,:index], Rubrik, :public=>true
    can :show, Neuigkeit, :rubrik=>{:public=>true}

    if loggedin
    end
    if( user.has_role?("fetuser") || user.has_role?("fetadmin"))
      can :showversions, Neuigkeit
      can :showintern, Neuigkeit
      can :showintern, Rubrik
      can :seeintern, User
      can :shownonpublic, Rubrik
      can :manage, Nlink
    end
    if user.has_role?("newsadmin") || user.has_role?("fetadmin") 
      can :addmoderator, Rubrik
    end    
    if user.has_role?("fetadmin")
      can :addfetuser, User
      can :addfetadmin, User
      can :edit, User
      can :manage, User
    end
    
    if user.has_role?("newsadmin") || user.has_role?( "fetadmin") || user.has_role?( "fetuser") 
      can :manage, Rubrik
      can :manage, Neuigkeit
      can :showunpublished, Neuigkeit
    end
    unless user.has_role?("fetadmin")
      cannot :delete, Rubrik
      cannot :delete, Neuigkeit

    end
    # Calendar
   if( user.has_role?("fetuser") || user.has_role?("fetadmin"))
     can :manage, Document
     can :manage, Meeting
     can :manage, Meetingtyp
   end    


    # Rechteverwaltung Kalender 
    can [:show, :index], Calendar, :public => true 
    can [:showics], Calendar
    can [:show], Calentry

    if( user.has_role?("fetuser") || user.has_role?("fetadmin"))


      can [:show,:index], Calendar
      can  [:edit, :update,:new,:create,:verwalten], Calendar
      can  [:edit, :update,:new,:create,:verwalten,:delete], Calentry
    end
    if( user.has_role?("fetadmin"))
      can [:delete],Calendar
      can [:delete],Calentry
      can :doadmin, User
    end

    unless user.has_role?("fetadmin")
    end
    
  end
end
