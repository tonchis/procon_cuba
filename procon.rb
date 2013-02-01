require_relative "init"
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
      res.redirect "dilemmas" if authenticated(User)
      unauthorized
    end

    on "signup" do
      res.write view("users/new")
    end

    on "login" do
      on get do
        res.write view("sessions/new")
      end

      on post, param("username"), param("password") do |username, password|
        if login(User, username, password)
          res.redirect "dilemmas"
        else
          res.redirect "login"
        end
      end
    end

    on "logout" do
      logout(User)
      res.redirect "login"
    end

    on "users" do
      on post, param("username"), param("passwd"), param("passwd_conf") do |username, passwd, passwd_conf|
        if passwd == passwd_conf
          User.create(username: username, password: passwd)
          res.redirect "login"
        else
          session[:error] = "Password and Password confirmation have to match."
          res.write view("users/new")
        end
      end

      on default do
        res.redirect "signup"
      end
    end

    on "dilemmas" do
      on authenticated(User) do
        on get do
          if req.xhr?
            res.write current_user.dilemmas_to_json
          else
            res.write view("dilemmas/index")
          end
        end

        on post, param("name") do |name|
          dilemma = current_user.add_dilemma(name: name)
          res.write dilemma.to_json
        end

        on ":id" do |id|
          dilemma = Dilemma[id]

          on put, param("reasons") do |reasons|
            dilemma.update_reasons(reasons.map {|reason| JSON.parse(reason)})
          end

          on delete do
            dilemma.delete
          end
        end
      end

      on default do
        unauthorized
      end
    end
  end
end

