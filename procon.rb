require_relative "config/init"

class Procon < Cuba
  use Rack::Session::Cookie, :secret => SecureRandom.hex(64)
  use Rack::Protection
  plugin Shield::Helpers

  define do
    on root do
      if authenticated(User)
        res.redirect "dilemmas"
      else
        res.redirect "login"
      end
    end

    # Session
    on "signup" do
      # render new user page
    end

    on "login" do
      on get  do
        # render login page
      end

      on post do
        # create login with Shield
      end
    end

    on "logout" do
      # logout with Shield
    end

    # Users
    on "users" do
      on post do
        # create new user
      end
    end

    # Dielemmas
    on authenticated(User) do
      on "dilemmas" do
        on get do
          # render index with all dilemmas
        end

        on post do
          # create new dilemma
        end

        on "new" do
          # render new dilema page
        end

        on ":id" do |id|
          on put do
            puts id
            # save dilemma
          end

          on delete do
            # delete dilemma
          end
        end
      end
    end
  end
end


