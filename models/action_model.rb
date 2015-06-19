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

  def event_data
    @action_json["action"]["data"]
  end

  def event_date
    DateTime.parse(@action_json["action"]["date"])
  end

  def event_type
    @action_json["action"]["type"]
  end

  def to_dict
    {id: id, card_id: card_id, board_id: board_id, event_data: event_data, event_type: event_type}
  end
end