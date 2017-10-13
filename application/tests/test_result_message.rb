require "test/unit"
require_relative "../result_message.rb"
class TestResultMessage < Test::Unit::TestCase

  def test_should_generate_a_message_only_containing_the_first_letter_of_the_lastname()
          json_message = '{"player" : {"firstName" : "Prenom","lastName" : "Nom","companyName" : "My Company","emailAddress" : "truc.much@mycompany.com","twitterAccount" : "toto@trucmuch.com"},"game" : {"score" : 1002,"rank":10}}'
          expected_message = "Prenom N est fort (e) comme HULK !\nEt toi ? Viens tester ta force sur le stand SQLI !#HerostandSQLI"
          result_message = ResultMessage.new(json_message)
          assert_equal(expected_message, result_message.message)
  end


end
