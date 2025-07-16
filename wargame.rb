class Card
  include Comparable
  attr_reader :rank, :suit

  RANKS = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    RANKS.index(rank)
  end

  def <=>(other)
    value <=> other.value
  end

  def to_s
    "#{rank}#{suit}"
  end
end

class Deck
  SUITS = ["♠", "♥", "♦", "♣"]

  def self.build
    Card::RANKS.product(SUITS).map { |rank, suit| Card.new(rank, suit) }.shuffle
  end
end

class Player
  attr_reader :name
  attr_accessor :deck

  def initialize(name, deck)
    @name = name
    @deck = deck
  end

  def out_of_cards?
    deck.empty?
  end

  def play_card
    deck.shift
  end

  def add_cards(cards)
    deck.concat(cards.shuffle)
  end
end

class WarGame
  def initialize(player_names)
    raise "Must have 2 to 4 players" unless (2..4).include?(player_names.size)

    full_deck = Deck.build
    hand_size = full_deck.size / player_names.size
    hands = full_deck.each_slice(hand_size).to_a
    @players = player_names.each_with_index.map { |name, i| Player.new(name, hands[i]) }
    @round = 1
  end

  def play
    until winner || @players.count { |p| !p.out_of_cards? } == 1
      puts "-- Round #{@round} --"
      play_round
      @round += 1
    end

    if winner
      puts "#{winner.name} wins the game with all the cards!"
    else
      surviving = @players.reject(&:out_of_cards?)
      puts "Game ended with no absolute winner, but #{surviving.map(&:name).join(', ')} survived."
    end
  end

  def winner
    @players.find { |p| p.deck.size == 52 }
  end

  def play_round(pile = [], participants = @players.reject(&:out_of_cards?))
    plays = participants.map { |player| [player, player.play_card] }.to_h
    plays.each { |player, card| puts "#{player.name} plays #{card}" }

    max_card = plays.values.compact.max
    top_players = plays.select { |_, card| card == max_card }.keys

    pile.concat(plays.values.compact)

    if top_players.size == 1
      winner = top_players.first
      puts "#{winner.name} wins the round and takes #{pile.size} cards."
      winner.add_cards(pile)
    else
      puts "War Round! #{top_players.map(&:name).join(' vs ')}"
      war_cards = {}

      top_players.each do |player|
        if player.deck.size >= 3
          war_cards[player] = 3.times.map { player.play_card }
        else
          war_cards[player] = player.deck.shift(player.deck.size)
        end
      end

      pile.concat(war_cards.values.flatten.compact)
      play_round(pile, top_players)
    end

    @players.reject!(&:out_of_cards?)
  end
end

if __FILE__ == $0
  names = ARGV.empty? ? ["Alice", "Bob"] : ARGV
  game = WarGame.new(names)
  game.play
end
