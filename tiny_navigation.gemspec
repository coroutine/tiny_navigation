# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tiny_navigation}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Coroutine", "Tim Lowrimore"]
  s.date = %q{2010-10-10}
  s.description = %q{TinyNavigation makes it easy to define site navigation using a small DSL.}
  s.email = %q{gems@coroutine.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     ".specification",
     "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "generators/tiny_navigation/USAGE",
     "generators/tiny_navigation/templates/tiny_navigation.rb",
     "generators/tiny_navigation/tiny_navigation_generator.rb",
     "init.rb",
     "lib/tiny_navigation.rb",
     "lib/tiny_navigation/controller/base.rb",
     "lib/tiny_navigation/data/config.rb",
     "lib/tiny_navigation/data/item.rb",
     "lib/tiny_navigation/data/navigation.rb",
     "rails/init.rb",
     "test/navigation_test.rb",
     "test/test_helper.rb",
     "tiny_navigation.gemspec"
  ]
  s.homepage = %q{http://github.com/coroutine/tiny_navigation}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{TinyNavigation provides an easy-to-use DSL for defining navigation structures.}
  s.test_files = [
    "test/navigation_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, [">= 2.3.4"])
      s.add_development_dependency(%q<activesupport>, [">= 2.3.4"])
    else
      s.add_dependency(%q<actionpack>, [">= 2.3.4"])
      s.add_dependency(%q<activesupport>, [">= 2.3.4"])
    end
  else
    s.add_dependency(%q<actionpack>, [">= 2.3.4"])
    s.add_dependency(%q<activesupport>, [">= 2.3.4"])
  end
end

