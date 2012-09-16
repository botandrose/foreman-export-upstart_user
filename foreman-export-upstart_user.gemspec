# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "foreman-export-upstart_user"
  s.version     = "0.0.1"
  s.authors     = ["Micah Geisel"]
  s.email       = ["micah@botandrose.com"]
  s.homepage    = "http://github.com/botandrose/foreman-export-upstart_user"
  s.summary     = "Upstart user-level export scripts for foreman"
  s.description = "Upstart user-level export scripts for foreman"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "foreman"
end
