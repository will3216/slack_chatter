require_relative './api.rb'
require_relative './auth.rb'
require_relative './channels.rb'
require_relative './chat.rb'
require_relative './emoji.rb'
require_relative './files.rb'
require_relative './groups.rb'
require_relative './im.rb'
require_relative './oauth.rb'
require_relative './rtm.rb'
require_relative './search.rb'
require_relative './stars.rb'
require_relative './team.rb'
require_relative './users.rb'

module SlackChatter
  module Api
    module Namespaces
      extend ActiveSupport::Concern

      included do
        def api
          @api ||= SlackChatter::Api::Api.new(self)
        end

        def auth
          @auth ||= SlackChatter::Api::Auth.new(self)
        end

        def channels
          @channels ||= SlackChatter::Api::Channels.new(self)
        end

        def chat
          @chat ||= SlackChatter::Api::Chat.new(self)
        end

        def emoji
          @emoji ||= SlackChatter::Api::Emoji.new(self)
        end

        def files
          @files ||= SlackChatter::Api::Files.new(self)
        end

        def groups
          @groups ||= SlackChatter::Api::Groups.new(self)
        end

        def im
          @im ||= SlackChatter::Api::Im.new(self)
        end

        def oauth
          @oath ||= SlackChatter::Api::Oauth.new(self)
        end

        def rtm
          @rtm ||= SlackChatter::Api::Rtm.new(self)
        end

        def search
          @search ||= SlackChatter::Api::Search.new(self)
        end

        def stars
          @stars ||= SlackChatter::Api::Stars.new(self)
        end

        def team
          @team ||= SlackChatter::Api::Team.new(self)
        end

        def users
          @users ||= SlackChatter::Api::Users.new(self)
        end
      end

    end
  end
end