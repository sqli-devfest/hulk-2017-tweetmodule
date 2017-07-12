require 'json'

class ResultMessage

  attr_reader :player_firstname, :player_lastname, :score, :rank

  @@corresponding_hero_by_rank = {

    1 => {name:"SUPER DUPONT",image_file:File.new("images/superdupont.jpeg","r")},
    2 => {name:"CAPITAIN AMERICA",image_file:File.new("images/captainamerica.jpg","r")},
    3 => {name:"FLASH",image_file:File.new("images/flash.jpg","r")},
    4 => {name:"BATMAN",image_file:File.new("images/batman.jpg","r")},
    5 => {name:"SPIDERMAN",image_file:File.new("images/spiderman.jpg","r")},
    6 => {name:"WOLVERINE",image_file:File.new("images/wolverine.jpg","r")},
    7 => {name:"IRON MAN",image_file:File.new("images/ironman.png","r")},
    8 => {name:"THOR",image_file:File.new("images/thor.jpg","r")},
    9 => {name:"SUPERMAN",image_file:File.new("images/superman.jpg","r")},
    10 => {name:"HULK",image_file:File.new("images/hulk.jpg","r")}

  }

  def initialize (json_message)
    message_hash = JSON.parse(json_message)
    @player_firstname = message_hash['player']['firstName']
    @player_lastname = message_hash['player']['lastName']
    @score = message_hash['game']['score']
    @rank = message_hash['game']['rank']
  end

  def message
    "#{player_firstname} #{player_lastname} est fort (e) comme #{corresponding_hero} !\nEt toi ? Viens tester ta force sur le stand SQLI !\#HerostandSQLI"
  end

  def corresponding_hero
    @@corresponding_hero_by_rank[rank][:name]
  end

  def corresponding_image
    @@corresponding_hero_by_rank[rank][:image_file]
  end

end
