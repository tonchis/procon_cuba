require_relative "config/init"
Dir["./models/*.rb"].each {|file| require file}
Dir["./lib/*.rb"].each {|file| require file}

class Procon < Cuba
  use Shield::Middleware, "/login"
  use Rack::Session::Cookie, Cuba.settings[:session]
  use Rack::Protection
  use Rack::Static,
      root: "public",
      urls: ["/js", "/css", "/img"]

  plugin Shield::Helpers
  plugin Cuba::Render
  plugin Helpers

  settings[:render][:template_engine] = "haml"

  define do
    on root do
      res.redirect "/dilemmas" if authenticated(User)
      res.status = 401
      halt(res.finish)
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
        if login(User, username, password)
          res.redirect "/dilemmas"
        else
          res.redirect "/login"
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
    on "dilemmas" do
      on authenticated(User)
        on get do
          res.write view("dilemmas/index")
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

      on default do
        res.status = 401
        halt(res.finish)
      end
    end
  end
end

