class Dilemma < Sequel::Model
  many_to_one :user
  one_to_many :reasons
end
