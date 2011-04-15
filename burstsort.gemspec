# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "burstsort/version"

Gem::Specification.new do |s|
  s.name        = "burstsort"
  s.version     = BurstSort::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sebastian Marr"]
  s.email       = ["sbstnmrr@googlemail.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby implementation of the burst sort algorithm}
  s.description = %q{Burst sort is an algorithm for sorting of large sets of strings.}

  s.rubyforge_project = "burstsort"

  s.files         = `hg manifest`.split("\n")
  s.test_files    = `hg locate --include test `.split("\n")
  s.executables   = `hg locate --include bin/`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
