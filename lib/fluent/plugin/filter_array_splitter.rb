# Apache License
#
# Version 2.0, January 2004
#
# Copyright (c) 2023 pcoffmanjr
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


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
