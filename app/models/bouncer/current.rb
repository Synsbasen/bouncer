module Bouncer
  class Current < ActiveSupport::CurrentAttributes
    attribute Bouncer.user_class.to_s.underscore.to_sym
  end
end
