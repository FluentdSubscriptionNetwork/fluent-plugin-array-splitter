require "helper"
require "fluent/plugin/filter_array_splitter.rb"

class ArraySplitterFilterTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
    @driver = create_driver
  end

  def create_driver(conf = "")
    Fluent::Test::Driver::Filter.new(Fluent::Plugin::ArraySplitterFilter).configure(Fluent::Config.parse(conf, "(test)", "(test_dir)", true))
  end

  sub_test_case "filter" do
    test "expand array in message field" do
      record = {
        "key1" => "hoge",
        "key2" => "foo",
        "key3" => "bar",
        "message" => ["v1", "v2", "v3"]
      }
      @driver.run(default_tag: "test") do
        @driver.feed(record)
      end
      filtered_records = @driver.filtered_records
      assert_equal(3, filtered_records.size)
      assert_equal("v1", filtered_records[0]["message"])
      assert_equal("v2", filtered_records[1]["message"])
      assert_equal("v3", filtered_records[2]["message"])
    end

    # More tests for other cases...
  end
end

