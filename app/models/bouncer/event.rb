module Bouncer
  class Event < ApplicationRecord
    belongs_to :user, class_name: Bouncer.user_class.to_s, polymorphic: true
  end
end
