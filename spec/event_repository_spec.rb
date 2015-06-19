require 'rspec'
require 'json'

require_relative '../models/action_model.rb'

describe 'Stores Events' do
  let(:webhook_action_json_data) {'{"action":{"id":"555f303f01d85e018ad447a2","idMemberCreator":"52cc8e1054e1b4ee3b64bc68","data":{"list":{"name":"Ready","id":"5526c4b91879384dfa09e78c"},"board":{"shortLink":"vNQFHLQp","name":"Brians work","id":"5526c40a2009a802149b7e28"},"card":{"shortLink":"oatNiGeU","idShort":7,"name":"Finish reviews","id":"5526c624d370692bbc237e09","pos":262143},"old":{"pos":131071}},"type":"updateCard","date":"2015-05-22T13:33:51.824Z","memberCreator":{"id":"52cc8e1054e1b4ee3b64bc68","avatarHash":"c5cbaff8af55fe12ac23de147d863bdc","fullName":"Brian Button","initials":"BAB","username":"brianbuttonxp"}},"model":{"id":"5526c40a2009a802149b7e28","name":"Brians work","desc":"","descData":null,"closed":false,"idOrganization":"5005e589b7ba66fe3d4da9a6","pinned":false,"url":"https://trello.com/b/vNQFHLQp/brians-work","shortUrl":"https://trello.com/b/vNQFHLQp","prefs":{"permissionLevel":"private","voting":"disabled","comments":"members","invitations":"members","selfJoin":false,"cardCovers":true,"cardAging":"regular","calendarFeedEnabled":false,"background":"blue","backgroundColor":"#0079BF","backgroundImage":null,"backgroundImageScaled":null,"backgroundTile":false,"backgroundBrightness":"unknown","canBePublic":false,"canBeOrg":true,"canBePrivate":true,"canInvite":true},"labelNames":{"green":"","yellow":"","orange":"","red":"","purple":"","blue":"","sky":"","lime":"","pink":"","black":""}}}'}

  context 'when parsing json returned from trello' do
    it 'should be identified by an action id' do
        json = JSON.parse(webhook_action_json_data)
        action = ActionModel.new(json)

        expect(action.id).to eq('555f303f01d85e018ad447a2')
    end

    it 'should contain the source card id' do
      json = JSON.parse(webhook_action_json_data)
      action = ActionModel.new(json)

      expect(action.card_id).to eq('5526c624d370692bbc237e09')
    end

    it 'should contain the id of the board that holds the card' do
      json = JSON.parse(webhook_action_json_data)
      action = ActionModel.new(json)

      expect(action.board_id).to eq('5526c40a2009a802149b7e28')
    end

    it 'should contain data specific to the event' do
      json = JSON.parse(webhook_action_json_data)
      action = ActionModel.new(json)
      data_hash = json["action"]["data"]
      expect(action.event_data).to eq(data_hash)
    end

    it 'should contain the datetime the event occurred' do
      json = JSON.parse(webhook_action_json_data)
      action = ActionModel.new(json)
      event_date = DateTime.parse('2015-05-22T13:33:51.824Z')

      expect(action.event_date).to eq(event_date)
    end

    it 'should contain the event type' do
      json = JSON.parse(webhook_action_json_data)
      action = ActionModel.new(json)

      expect(action.event_type).to eq("updateCard")
    end

    it 'should be able to represent itself as a hash dictionary' do
      json = JSON.parse(webhook_action_json_data)
      action = ActionModel.new(json)
      dictionary = action.to_dict

      expect(dictionary[:id]).to eq('555f303f01d85e018ad447a2')
    end
  end
end