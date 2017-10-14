require 'json'

class ResultMessage

  attr_reader :player_firstname, :player_lastname, :score, :rank

  @@corresponding_hero_by_rank = {

    1 => {name:"SUPER DUPONT",image_id:"918462225974743045"},
    2 => {name:"CAPITAIN AMERICA",image_id:"918462178772049921"},
    3 => {name:"FLASH",image_id:"918462187080994816"},
    4 => {name:"BATMAN",image_id:"918462165195116544"},
    5 => {name:"SPIDERMAN",image_id:"918462218416607233"},
    6 => {name:"WOLVERINE",image_id:"918462253422317568"},
    7 => {name:"IRON MAN",image_id:"918462209285554176"},
    8 => {name:"THOR",image_id:"918462245167947776"},
    9 => {name:"SUPERMAN",image_id:"918462234342412289"},
    10 => {name:"HULK",image_id:"918462200951525376"}

  }

  def initialize (json_message,devfestTwitterAccount,sqliTwitterAccount)
    message_hash = JSON.parse(json_message)
    @player_firstname = message_hash['player']['firstName']
    @player_lastname = "#{message_hash['player']['lastName'][0]}"
    @player_twitter_handle = message_hash['player']['twitterAccount']
    @score = message_hash['game']['score']
    @rank = message_hash['game']['rank']
    @devfestTwitterAccount = devfestTwitterAccount
    @sqliTwitterAccount = sqliTwitterAccount
  end

  def message
    name = (@player_twitter_handle.nil? or @player_twitter_handle.empty?) ? "#{player_firstname} #{player_lastname}" : @player_twitter_handle
    "#{name} est fort (e) comme #{corresponding_hero} !\nEt toi ? Viens tester ta force sur le stand SQLI !\##{@devfestTwitterAccount} @#{@devfestTwitterAccount} @#{@sqliTwitterAccount}"
  end

  def corresponding_hero
    @@corresponding_hero_by_rank[rank][:name]
  end

  def corresponding_image_id
    @@corresponding_hero_by_rank[rank][:image_id]
  end

end
