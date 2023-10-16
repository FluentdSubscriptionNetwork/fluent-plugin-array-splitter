lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name    = "fluent-plugin-array-splitter"
  spec.version = "0.1.2"
  spec.authors = ["pcoffmanjr"]
  spec.email   = ["pcoffman@ctc-america.com"]

  spec.summary       = %q{A Fluentd plugin to split array values into separate records.}
  spec.description   = %q{This Fluentd plugin takes array values from a specified field and creates separate records for each array element.}
  spec.homepage      = "https://github.com/paulcoffmanjr/fluent-plugin-array-splitter"
  spec.license       = "MIT"

  test_files, files  = `git ls-files -z`.split("\x0").partition do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.files         = files
  spec.executables   = files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = test_files
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.2"
  spec.add_development_dependency "rake", "~> 13.0.6"
  spec.add_development_dependency "test-unit", "~> 3.3.9"
  spec.add_runtime_dependency "fluentd", [">= 0.14.10", "< 2"]
end
