# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "resque_any_method/version"

Gem::Specification.new do |s|
  s.name        = "resque_any_method"
  s.version     = ResqueAnyMethod::VERSION
  s.authors     = ["Ian Ehlert"]
  s.email       = ["ian.ehlert@tstmedia.com"]
  s.homepage    = "https://github.com/ehlertij/resque_any_method"
  s.summary     = %q{Provides Resque with functionality to asynchronously process any method.}
  s.description = %q{Provides Resque with functionality to asynchronously process any method. This can help clean up the default Resque code that is requred to process your methods.}

  s.rubyforge_project = "resque_any_method"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "resque"
end
