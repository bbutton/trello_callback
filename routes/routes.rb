require 'json'
require 'orchestrate'

require_relative '../models/action_model'

post '/trello_callback/:board_name' do |board_name|
  puts "Callback for board #{board_name}"

  begin
    trello_action = request.body.read

    puts "Raw action body: #{trello_action}"
    $stdout.flush

    action_json = JSON.parse(trello_action)
    action_model = ActionModel.new(action_json)

    puts "Storing event for card #{action_model.card_id}, type:#{action_model.event_type}, data:#{action_model.event_data}"
    $stdout.flush

    app = Orchestrate::Application.new(ENV["ORCHESTRATE_API_KEY"], ENV["ORCHESTRATE_ENDPOINT"])
    trello_data = app[:TrelloData]
    card_obj = trello_data[action_model.card_id]

    action_date = action_model.event_date
    ruby_date = DateTime.parse(action_date.to_s)
    iso_8601_date = ruby_date.iso8601

    card_obj.events[:card_actions][iso_8601_date] << action_model.event_data
    puts "Event stored"
    $stdout.flush

    200
  rescue Exception => e
    puts "Exception thrown during processing: #{e.message}"
    puts "Stack track for exception: #{e.backtrace}"

    500
  end

end

get '/trello_callback/:board_name' do
  200
end