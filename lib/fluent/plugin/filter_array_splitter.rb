

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
              new_record.delete('message')
              if value.is_a?(Hash)
                value.each do |k, v|
                  new_record[k] = v 
                end
              else
                new_record['message'] = value
              end
              new_es.add(time, new_record)
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

