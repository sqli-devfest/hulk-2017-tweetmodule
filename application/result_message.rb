require 'json'

class ResultMessage

  attr_reader :player_firstname, :player_lastname, :score, :rank, :genderMale

  @@corresponding_hero_by_rank = {

    1 => {name:"SUPER DUPONT",image_file:File.new("images/superdupont.png","r")},
    2 => {name:"CAPITAIN AMERICA",image_file:File.new("images/captainamerica.png","r")},
    3 => {name:"FLASH",image_file:File.new("images/flash.png","r")},
    4 => {name:"BATMAN",image_file:File.new("images/batman.png","r")},
    5 => {name:"SPIDERMAN",image_file:File.new("images/spiderman.png","r")},
    6 => {name:"WOLVERINE",image_file:File.new("images/wolverine.png","r")},
    7 => {name:"IRON MAN",image_file:File.new("images/ironman.png","r")},
    8 => {name:"THOR",image_file:File.new("images/thor.png","r")},
    9 => {name:"SUPERMAN",image_file:File.new("images/superman.png","r")},
    10 => {name:"HULK",image_file:File.new("images/hulk.png","r")}

  }

  def initialize (json_message,devfestTwitterAccount,sqliTwitterAccount)
    message_hash = JSON.parse(json_message)
    @player_firstname = message_hash['player']['firstName']
    @player_lastname = "#{message_hash['player']['lastName'][0]}"
    @player_twitter_handle = message_hash['player']['twitterAccount']
    @genderMale = !message_hash['player']['genderMale'].nil? ? message_hash['player']['genderMale'] : true
    @score = message_hash['game']['score']
    @rank = message_hash['game']['rank']
    @devfestTwitterAccount = devfestTwitterAccount
    @sqliTwitterAccount = sqliTwitterAccount
  end

  def message
    name = (@player_twitter_handle.nil? or @player_twitter_handle.empty?) ? "#{player_firstname} #{player_lastname}" : @player_twitter_handle

    strong = (@genderMale) ? "fort" : "forte"

    message = "#{name} est #{strong} comme #{corresponding_hero} !\nEt toi ? Viens tester ta force sur le stand SQLI ! @#{@devfestTwitterAccount}"

    additional_twitter_hashes = " \##{@devfestTwitterAccount} @#{@sqliTwitterAccount}"

    if ((message.length + additional_twitter_hashes.length) <= 140) then
      message = message + additional_twitter_hashes
    end

    return message
  end

  def corresponding_hero
    @@corresponding_hero_by_rank[rank][:name]
  end

  def corresponding_image
    @@corresponding_hero_by_rank[rank][:image_file]
  end

end
