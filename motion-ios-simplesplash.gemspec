# -*- encoding: utf-8 -*-
VERSION = "0.1.0"

Gem::Specification.new do |spec|
  spec.name          = "motion-ios-simplesplash"
  spec.version       = VERSION
  spec.authors       = ["Andy Stechishin"]
  spec.email         = ["andy@canasoftware.ca"]
  spec.description   = %q{Generate a simple splash page in a storyboard file}
  spec.summary       = %q{Generate a simple splash page in a storyboard file}
  spec.homepage      = ""
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "builder", '>=3.2.2'
end
