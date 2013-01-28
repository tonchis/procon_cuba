class User < Sequel::Model
  include Shield::Model

  def self.fetch(username)
    [username: username].first
  end
end

