require 'json'

require_relative '../models/action_model'
require_relative '../models/event_processor'
require_relative '../models/orchestrate_gateway'

post '/trello_callback/:board_name' do |board_name|
  puts "Callback for board #{board_name}"

  begin
    trello_action = request.body.read

    puts "Raw action body: #{trello_action}"
    $stdout.flush

    action_json = JSON.parse(trello_action)
    action_model = ActionModel.new(action_json)

    puts "Storing event for card #{action_model.card_id}, type:#{action_model.event_type}, data:#{action_model.event_data} date:#{action_model.event_date}"
    $stdout.flush

    orchestrate_gateway = OrchestrateGateway.new(ENV["ORCHESTRATE_API_KEY"], ENV["ORCHESTRATE_ENDPOINT"], ENV["ORCHESTRATE_COLLECTION_NAME"])
    event_processor = EventProcessor.new(orchestrate_gateway)
    event_processor.process(action_model)

    puts "Event stored"
    $stdout.flush

    200
  rescue Exception => e
    puts "Exception thrown during processing: #{e.message}"
    puts "Stack track for exception: #{e.backtrace}"
    $stdout.flush

    500
  end

end

get '/trello_callback/:board_name' do
  200
end