# MIT License

# Copyright (c) 2023 pcoffmanjr

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


require "fluent/plugin/filter"

module Fluent
  module Plugin
    class ArraySplitterFilter < Fluent::Plugin::Filter
      Fluent::Plugin.register_filter("array_splitter", self)

      desc 'The field name to split and expand array values'
      config_param :array_key, :string, default: 'message'

      desc 'The field name to rename the key of a single array element'
      config_param :key_name, :string, default: nil

      def configure(conf)
        super
        raise Fluent::ConfigError, "'array_key' parameter is required" unless conf.has_key?('array_key')
        log.info "Configuring Array Splitter Filter"
      end

      def filter_stream(tag, es)
        new_es = Fluent::MultiEventStream.new

        es.each do |time, record|
          if record[@array_key].is_a?(Array)
            record[@array_key].each do |value|
              new_record = record.dup
              new_record.delete(@array_key)

              if value.is_a?(Hash)
                value.each { |k, v| new_record[k] = v }
              else
                new_record[@key_name.nil? ? @array_key : @key_name] = value
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
