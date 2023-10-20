# fluent-plugin-array-splitter


## Overview
This [Fluentd](https://fluentd.org/) filter plugin enables splitting and expanding array values within log records. 

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

- `array_key`: The field name to split and expand array values (default: 'message').
- `key_name`: The field name to rename the key of a single array element (default: null).

### Example Configuration

```
<filter pattern>
  @type array_splitter
  array_key message
  key_name new_key
</filter>
```

## Usage

With the above configuration, an input like {"message": ["value1", "value2"]} will result in two records:

```
{"new_key": "value1"}
{"new_key": "value2"}
```

## Copyright

* Copyright(c) 2023- pcoffmanjr
* License
  * 
