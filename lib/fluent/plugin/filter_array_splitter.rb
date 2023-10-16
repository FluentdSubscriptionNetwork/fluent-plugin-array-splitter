

require "fluent/plugin/filter"

module Fluent
  module Plugin
    class ArraySplitterFilter < Fluent::Plugin::Filter
      Fluent::Plugin.register_filter("array_splitter", self)

      def configure(conf)
        super
        log.info "Configuring Array Splitter Filter"
      end

      def filter_stream(tag, es)
        new_es = Fluent::MultiEventStream.new
        es.each do |time, record|
          if record['message'].is_a?(Array)
            record['message'].each do |value|
              new_record = record.dup
              new_record['message'] = value
              new_es.add(time, new_record)
            end
          elsif record['target_field'].is_a?(Array)
            record['target_field'].each do |hash|
              hash.each do |k, v|
                new_record = record.dup
                new_record.delete('target_field')
                new_record[k] = v
                new_es.add(time, new_record)
              end
            end
          else
            new_es.add(time, record)
          end
        end
        new_es
      end
    end
  end
end

