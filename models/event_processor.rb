require_relative '../models/orchestrate_gateway'

class EventProcessor
  def initialize(orchestrate_gateway)
    @orchestrate_gateway = orchestrate_gateway
  end

  def process(action_model)
    case action_model.event_type
      when "createCard"
        @orchestrate_gateway.add_card_to_board(action_model)
      else
        @orchestrate_gateway.add_event_to_card(action_model)
    end
  end
end