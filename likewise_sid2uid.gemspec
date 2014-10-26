# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'likewise_sid2uid/version'

Gem::Specification.new do |gem|
  gem.name          = 'likewise_sid2uid'
  gem.version       = LikewiseSid2uid::VERSION
  gem.authors       = ['Don Reilly']
  gem.email         = ['dreilly1982@gmail.com']
  gem.description   = %q{Converts Object SID from Active Directory to Likewise UID, for use in applications that require a UID.}
  gem.summary       = %q{Converts Object SID from Active Directory to Likewise UID}
  gem.homepage      = 'https://github.com/dreilly1982/likewise_sid2uid'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
