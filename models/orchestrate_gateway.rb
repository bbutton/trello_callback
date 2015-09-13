require 'orchestrate'

class OrchestrateGateway
  def initialize(api_key, endpoint, collection_name)
    app = Orchestrate::Application.new(api_key, endpoint)
    @trello_data = app[collection_name]
  end

  def add_event_to_card(action_model)
    puts "Added event to card #{action_model.card_id}"
    card_obj = @trello_data[action_model.card_id]

    action_date = action_model.event_date
    ruby_date = DateTime.parse(action_date.to_s)
    iso_8601_date = ruby_date.iso8601

    card_obj.events[:card_actions][iso_8601_date] << action_model.to_dict
  end

  def add_card_to_board(action_model)
    card_id = action_model.card_id
    puts "Adding card #{card_id} to board now"
    @trello_data.set(card_id,
                     {
                         "id" => card_id,
                        "trello_type" => "card",
                        "board_id" => action_model.board_id,
                        "name" => action_model.card_name,
                        "desc" => action_model.card_desc,
                        "list_id" => action_model.list_id,
                        "last_activity_date" => action_model.event_date,
                        "labels" => []
                     })
  end
end


