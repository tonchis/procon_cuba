require_relative "config/init"
Dir["./models/*.rb"].each {|file| require file}

class Procon < Cuba
  use Rack::Session::Cookie, :secret => SecureRandom.hex(64)
  use Rack::Protection
  use Rack::Static,
      root: "public",
      urls: ["/js", "/css", "/img"]

  plugin Shield::Helpers
  plugin Cuba::Render

  settings[:render][:template_engine] = "haml"

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
      res.write view("users/new")
    end

    on "login" do
      on get do
        res.write view("sessions/new")
      end

      on post, param("username"), param("password") do |username, password|
        user = User.authenticate(username, password)
        if user
          res.redirect "dilemmas"
        else
          res.redirect "login"
        end
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

