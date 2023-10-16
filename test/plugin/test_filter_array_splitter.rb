require "helper"
require "fluent/plugin/filter_array_splitter.rb"

class ArraySplitterFilterTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "failure" do
    flunk
  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Filter.new(Fluent::Plugin::ArraySplitterFilter).configure(conf)
  end
end
