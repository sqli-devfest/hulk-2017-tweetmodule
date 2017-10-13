require "test/unit"
require_relative "../result_message.rb"
class TestResultMessage < Test::Unit::TestCase

  def test_should_generate_a_message_only_containing_the_first_letter_of_the_lastname()
          json_message = '{"player" : {"firstName" : "Prenom","lastName" : "Nom","companyName" : "My Company","emailAddress" : "truc.much@mycompany.com","twitterAccount" : ""},"game" : {"score" : 1002,"rank":10}}'
          expected_message = "Prenom N est fort (e) comme HULK !\nEt toi ? Viens tester ta force sur le stand SQLI !#HerostandSQLI"
          result_message = ResultMessage.new(json_message)
          assert_equal(expected_message, result_message.message)
  end

  def test_should_use_tweeter_handle_when_present()
          json_message = '{"player" : {"firstName" : "Prenom","lastName" : "Nom","companyName" : "My Company","emailAddress" : "truc.much@mycompany.com","twitterAccount" : "@toto"},"game" : {"score" : 1002,"rank":10}}'
          expected_message = "@toto est fort (e) comme HULK !\nEt toi ? Viens tester ta force sur le stand SQLI !#HerostandSQLI"
          result_message = ResultMessage.new(json_message)
          assert_equal(expected_message, result_message.message)
  end

  def test_should_use_firstname_and_lastname_when_twitter_handle_is_blank()
          json_message_with_blank_twitter_account = '{"player" : {"firstName" : "Prenom","lastName" : "Nom","companyName" : "My Company","emailAddress" : "truc.much@mycompany.com","twitterAccount" : ""},"game" : {"score" : 1002,"rank":10}}'
          expected_message = "Prenom N est fort (e) comme HULK !\nEt toi ? Viens tester ta force sur le stand SQLI !#HerostandSQLI"
          result_message = ResultMessage.new(json_message_with_blank_twitter_account)
          assert_equal(expected_message, result_message.message)
  end

  def test_should_use_firstname_and_lastname_when_twitter_handle_field_is_absent_from_json_message()
          json_message_with_absent_twitter_account_field = '{"player" : {"firstName" : "Prenom","lastName" : "Nom","companyName" : "My Company","emailAddress" : "truc.much@mycompany.com"},"game" : {"score" : 1002,"rank":10}}'
          expected_message = "Prenom N est fort (e) comme HULK !\nEt toi ? Viens tester ta force sur le stand SQLI !#HerostandSQLI"
          result_message = ResultMessage.new(json_message_with_absent_twitter_account_field)
          assert_equal(expected_message, result_message.message)
  end



end
