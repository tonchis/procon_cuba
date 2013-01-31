class Reason < Sequel::Model
  many_to_one :dilemma
end

