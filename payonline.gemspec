$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "payonline/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "payonline"
  s.version     = Payonline::VERSION
  s.authors     = ["Alekseenko Sergey"]
  s.email       = ["alekseenkoss@gmail.com"]
  s.homepage    = ""
  s.summary     = ""
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
end
