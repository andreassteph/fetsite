class Fetprofile < ActiveRecord::Base
  attr_accessible :active, :desc, :fetmailalias, :nachname, :picture, :short, :vorname
end
