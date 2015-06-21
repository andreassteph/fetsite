require 'flagable'
ActionController::Base.send :include, Flagable::ActsAsFlagableController
ActiveRecord::Base.send :include, Flagable::ActsAsFlagableRecord
ActionView::Base.send :include, Flagable::FlagableHelper
