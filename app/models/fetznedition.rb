# == Schema Information
#
# Table name: fetzneditions
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  desc       :text
#  datum      :date
#  datei      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Fetznedition < ActiveRecord::Base
  attr_accessible :datei, :datum, :desc, :title
end
