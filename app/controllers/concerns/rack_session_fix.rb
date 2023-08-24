# This module provides a fix for Rack session behavior.
# It extends ActiveSupport::Concern to include methods that
# handle fake Rack session in certain scenarios.
module RackSessionFix
  extend ActiveSupport::Concern

  # A hash-based class that simulates a disabled Rack session.
  class FakeRackSession < Hash
    def enabled?
      false
    end
  end
  included do
    before_action :set_fake_rack_session_for_devise

    private

    def set_fake_rack_session_for_devise
      request.env['rack.session'] ||= FakeRackSession.new
    end
  end
end
