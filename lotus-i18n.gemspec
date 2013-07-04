# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "lotus-i18n/version"

Gem::Specification.new do |s|
  s.name        = "lotus-i18n"
  s.version     = Lotus::I18N_VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Hackers of the Severed Hand']
  s.email       = ['hotsh@xomb.org']
  s.homepage    = "http://github.com/hotsh/lotus-i18n"
  s.summary     = %q{Localization strings for lotus, a generalized federated system backend for social networks with ActivityStreams/OStatus/pump.io.}
  s.description = %q{This gem contains localization effort for lotus, a gem which allows easier implementation and utilization of distributed, federated social networks.}

  s.add_dependency "i18n"

  s.add_development_dependency "rspec", "~> 2.10.0"
  s.add_development_dependency "rake", "~> 0.9.2"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
