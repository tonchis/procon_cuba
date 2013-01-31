module Helpers
  def current_user
    authenticated(User)
  end

  def unauthorized
    res.status = 401
    halt(res.finish)
  end
end

