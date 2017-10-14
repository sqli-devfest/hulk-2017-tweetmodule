require "test/unit"
require_relative "../configuration.rb"
class TestResultMessage < Test::Unit::TestCase

  def test_should_load_dev_sqli_twitter_account()
          config = Configuration.new("dev")
          assert_equal("sqliTest", config.sqliTwitterAccount)
  end

  def test_should_load_dev_devfest_twitter_account()
          config = Configuration.new("dev")
          assert_equal("devfestTest", config.devfestTwitterAccount)
  end

  def test_should_load_prod_sqli_twitter_account()
          config = Configuration.new("prod")
          assert_equal("SQLI_FR", config.sqliTwitterAccount)
  end

  def test_should_load_prod_devfest_twitter_account()
          config = Configuration.new("prod")
          assert_equal("devfestnantes", config.devfestTwitterAccount)
  end

end
