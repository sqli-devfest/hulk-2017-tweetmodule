require 'json'

class ResultMessage

  attr_reader :player_firstname, :player_lastname, :score, :rank

  def initialize (json_message)
    message_hash = JSON.parse(json_message)
    @player_firstname = message_hash['player']['firstName']
    @player_lastname = message_hash['player']['lastName']
    @score = message_hash['game']['score']
    @rank = message_hash['game']['rank']
  end

  def message
    "#{player_firstname} #{player_lastname} a fait un score de #{score}"
  end


end
