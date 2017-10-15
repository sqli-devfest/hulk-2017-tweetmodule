require "test/unit"
require_relative "../result_message.rb"
class TestResultMessage < Test::Unit::TestCase

  @devfestTwitterAccount="devfest"
  @sqliTwitterAccount="sqli"


  def test_should_generate_a_message_only_containing_the_first_letter_of_the_lastname()
          json_message = '{"player" : {"firstName" : "Prenom","lastName" : "Nom","companyName" : "My Company","emailAddress" : "truc.much@mycompany.com","twitterAccount" : ""},"game" : {"score" : 1002,"rank":10}}'
          expected_message_regexp = /^Prenom N.*/
          result_message = ResultMessage.new(json_message,@devfestTwitterAccount,@sqliTwitterAccount)
          assert(result_message.message.match(expected_message_regexp))
  end

  def test_should_use_tweeter_handle_when_present()
          json_message = '{"player" : {"firstName" : "Prenom","lastName" : "Nom","companyName" : "My Company","emailAddress" : "truc.much@mycompany.com","twitterAccount" : "@toto"},"game" : {"score" : 1002,"rank":10}}'
          expected_message_regexp = /^@toto.*/
          result_message = ResultMessage.new(json_message,@devfestTwitterAccount,@sqliTwitterAccount)
          assert(result_message.message.match(expected_message_regexp))
  end

  def test_should_use_firstname_and_lastname_when_twitter_handle_is_blank()
          json_message_with_blank_twitter_account = '{"player" : {"firstName" : "Prenom","lastName" : "Nom","companyName" : "My Company","emailAddress" : "truc.much@mycompany.com","twitterAccount" : ""},"game" : {"score" : 1002,"rank":10}}'
          expected_message_regexp = /^Prenom N.*/
          result_message = ResultMessage.new(json_message_with_blank_twitter_account,@devfestTwitterAccount,@sqliTwitterAccount)
          assert(result_message.message.match(expected_message_regexp))
  end

  def test_should_use_firstname_and_lastname_when_twitter_handle_field_is_absent_from_json_message()
          json_message_with_absent_twitter_account_field = '{"player" : {"firstName" : "Prenom","lastName" : "Nom","companyName" : "My Company","emailAddress" : "truc.much@mycompany.com"},"game" : {"score" : 1002,"rank":10}}'
          expected_message_regexp = /^Prenom N.*/
          result_message = ResultMessage.new(json_message_with_absent_twitter_account_field,@devfestTwitterAccount,@sqliTwitterAccount)
          assert(result_message.message.match(expected_message_regexp))
  end

  def test_should_add_additional_twitter_hashes_if_message_length_is_short_enough()
          json_message_with_absent_twitter_account_field = '{"player" : {"firstName" : "Prenom","lastName" : "Nom","companyName" : "My Company","emailAddress" : "truc.much@mycompany.com"},"game" : {"score" : 1002,"rank":10}}'
          devfestTwitterAccount = "devfest"
          sqliTwitterAccount = "sqli"
          expected_message_regexp = /.* ##{devfestTwitterAccount} @#{sqliTwitterAccount}$/
          result_message = ResultMessage.new(json_message_with_absent_twitter_account_field,devfestTwitterAccount,sqliTwitterAccount)
          puts result_message.message
          assert(result_message.message.match(expected_message_regexp))
  end

  def test_should_omit_additional_twitter_hashes_if_message_length_is_too_long()
          json_message_with_absent_twitter_account_field = '{"player" : {"firstName" : "Prenom","lastName" : "Nom","companyName" : "My Company","emailAddress" : "truc.much@mycompany.com"},"game" : {"score" : 1002,"rank":10}}'
          devfestTwitterAccount = "devfestTwitterAccount"
          sqliTwitterAccount = "sqliTwitterAccount"
          expected_message_regexp = /.* @#{devfestTwitterAccount}$/
          result_message = ResultMessage.new(json_message_with_absent_twitter_account_field,devfestTwitterAccount,sqliTwitterAccount)
          puts result_message.message
          assert(result_message.message.match(expected_message_regexp))
  end



end
