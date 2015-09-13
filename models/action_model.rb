class ActionModel

  def initialize(action_json)
    @action_json = action_json
  end

  def id
    @action_json["action"]["id"]
  end

  def card_id
    @action_json["action"]["data"]["card"]["id"]
  end

  def board_id
    @action_json["action"]["data"]["board"]["id"]
  end

  def list_id
    @action_json["action"]["data"]["list"]["id"]
  end

  def event_data
    @action_json["action"]["data"]
  end

  def event_date
    @action_json["action"]["date"]
  end

  def event_type
    @action_json["action"]["type"]
  end

  def to_dict
    {id: id, :type => event_type, :card_id => card_id, :data => event_data, :date => event_date}
  end

  def card_name
    @action_json["action"]["data"]["card"]["name"]
  end

  def card_desc
    ""
  end

end