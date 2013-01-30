class User < Sequel::Model
  include Shield::Model

  def self.fetch(username)
    self[username: username]
  end
end

