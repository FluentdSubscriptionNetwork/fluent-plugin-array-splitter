# fluent-plugin-array-splitter

## Overview
This [Fluentd](https://www.fluentd.org/) filter plugin allows you to split array values within json formatted log records.

## Installation

### RubyGems

```
$ gem install fluent-plugin-array-splitter
```

### Bundler

Add following line to your Gemfile:

```ruby
gem "fluent-plugin-array-splitter"
```

And then execute:

```
$ bundle
```

## Configuration

### Parameters

|parameter|type|description|default|
|---|---|---|---|
|array_key|string (required)|The target field name to split array values||
|key_name|string (optional)|The field name to rename the key of a single array element|nil|

### Example Configuration

```
<filter pattern>
  @type array_splitter
  array_key message
  key_name new_key
</filter>
```

## Usage

With the above configuration, an input like:
```
{"message": ["value1", "value2"]}
```

will result in two records:
```
{"new_key": "value1"}
{"new_key": "value2"}
```

If you have an input like:
```
{"message": [{"key1": "value1"}, {"key2": "value2"}]}
```
will result as follows:
```
{"key1": "value1"}
{"key2": "value2"}
```

## Copyright

* Copyright(c) 2023- pcoffmanjr
* License
  * Apache License, Version 2.0
