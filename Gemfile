source 'https://rubygems.org'

# Specify your gem's dependencies in peacock.gemspec
gemspec
gem.authors       = ["David Clarke"]
gem.email         = ["terrorhawks@gmail.com"]
gem.description   = %q{Capistrano plugin for green blue deployments to AWS Elastic Load Balancer}
gem.summary       = %q{Use this gem as a plugin to Capistrano to deploy using green/build to EC2 instances behind an Elastic Load Balancer}
gem.homepage      = "https://github.com/terrorhawks/peacock"

gem.files         = `git ls-files`.split($\)
gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
gem.name          = "peacock"
gem.require_paths = ["lib"]
gem.version       = Peacock::VERSION
gem.add_dependency('aws-sdk')
gem.add_dependency('net-dns')
