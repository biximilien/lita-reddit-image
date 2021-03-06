require "./lib/lita/handlers/reddit_image/version"

Gem::Specification.new do |spec|
  spec.name          = "lita-reddit-image"
  spec.version       = Lita::Handlers::RedditImage::VERSION
  spec.authors       = ["Maxime 'biximilien' Gauthier"]
  spec.email         = ["maxime.gauthier88@gmail.com"]
  spec.description   = "Lita handler to fetch images from reddit."
  spec.summary       = "Fetch reddit images."
  spec.homepage      = "https://github.com/biximilien/lita-reddit-image"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.8"
  spec.add_runtime_dependency "rest-client"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
end
