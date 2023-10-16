

require "fluent/plugin/filter"

module Fluent
  module Plugin
    class ArraySplitterFilter < Fluent::Plugin::Filter
      Fluent::Plugin.register_filter("array_splitter", self)

      def filter(tag, time, record)
      end
    end
  end
end
