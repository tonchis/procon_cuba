require "cuba"
require "rack/protection"
require "securerandom"

Cuba.use Rack::Session::Cookie, :secret => SecureRandom.hex(64)
Cuba.use Rack::Protection

Cuba.define do
  on root do
    # redirect "login" unless authenticated(User)
    res.redirect "/dilemmas"
  end

  # Authentication
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
  on "dilemmas" do
    on get do
      res.write "cucucu"
      # render index with dilemmas
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

  on default do
    res.write "loldefaultz"
  end
end

