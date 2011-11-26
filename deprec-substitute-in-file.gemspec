# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "deprec-substitute-in-file"
  s.version     = "0.9.9"
  s.authors     = ["Ewout Vonk"]
  s.email       = ["dev@ewout.to"]
  s.homepage    = "https://github.com/ewoutvonk/deprec-substitute-in-file"
  s.summary     = %q{allow string substitutions in files on the server}
  s.description = %q{allow string substitutions in files on the server}

  s.rubyforge_project = "deprec-substitute-in-file"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "deprec"
  s.add_runtime_dependency "capistrano"
end
