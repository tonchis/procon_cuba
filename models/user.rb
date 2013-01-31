class User < Sequel::Model
  include Shield::Model

  def self.fetch(username)
    self[username: username]
  end

  one_to_many :dilemmas

  def dilemmas_to_json
    dilemmas_dataset.eager(:reasons).to_json(include: :reasons)
  end
end

