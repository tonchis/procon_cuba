class Dilemma < Sequel::Model
  many_to_one :user
  one_to_many :reasons

  def update_reasons(reasons)
    old_reasons_id = reasons_dataset.map(:id)
    delete_ids = old_reasons_id - reasons.map {|reason| reason["id"]}
    Reason[id: delete_ids].delete unless delete_ids.empty?

    new = reasons.select {|reason| reason["id"].nil?}
    new.each {|reason| add_reason(reason)} unless new.empty?
  end
end
