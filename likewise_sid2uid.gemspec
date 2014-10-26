# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'likewise_sid2uid/version'

Gem::Specification.new do |gem|
  gem.name          = 'likewise_sid2uid'
  gem.version       = LikewiseSid2uid::VERSION
  gem.authors       = ['Don Reilly']
  gem.email         = ['dreilly1982@gmail.com']
  gem.description   = %q{Converts Object SID from Active Directory to Likewise UID}
  gem.summary       = %q{Converts Object SID from Active Directory to Likewise UID}
  gem.homepage      = ''

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
