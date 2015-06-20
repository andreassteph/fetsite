require 'flagable'
ActionController::Base.send :include, Flagable::ActsAsFlagable
