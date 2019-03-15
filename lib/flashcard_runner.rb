require './lib/card'
require './lib/turn'
require './lib/deck'
require './lib/round'
require './lib/card_generator'
require 'pry'

generator = CardGenerator.new('cards.txt')
cards = generator.cards
#creates category array to iterate through
categories = generator.category_arr
#deletes duplicate categories in array
categories.uniq!
deck = Deck.new(cards)
round = Round.new(deck)

def start(round, categories)
  #welcome message
  p "Welcome! You're playing with #{round.deck.cards.length} cards."
  p '*' * 64
  #game loop until all cards are iterated through
  until round.turn_index == round.deck.cards.length
    p "This is card #{round.turn_index + 1} out of #{round.deck.cards.length}"
    p "Question: #{round.current_card.question}"
    #allows input to match answer despite case
    input = gets.chomp.downcase
    round.take_turn(input)
    p round.turns[round.turn_index - 1].feedback
    p '*' * 64 if round.turn_index != round.deck.cards.length
  end
  #end of game message with stats
  p '*' * 27 + "Game Over!" + '*' * 27
  p "You had #{round.number_correct} correct guesses out of #{round.deck.cards.length} for a total score of #{round.percent_correct.round(2)}%"
  #prints each category and percentage of correct answers per category
  categories.each do |category|
    p "#{category} - #{round.percent_correct_by_category(category.delete(' ').to_sym)}%"
  end
end

start(round, categories)
