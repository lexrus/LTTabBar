Pod::Spec.new do |s|
  s.name         = "LTTabBar"
  s.version      = "0.0.1"
  s.summary      = "A clumsy mimic of the Chrome-style tab bar for iOS."
  s.homepage     = "https://github.com/lexrus/LTTabBar"

  s.license      = 'MIT'
  s.author       = { "Lex Tang" => "lexrus@gmail.com" }
  s.source       = { :git => "https://github.com/lexrus/LTTabBar.git", :tag => "0.0.1" }
  s.platform     = :ios
  s.source_files = 'LTTabBar'
  s.framework    = 'CoreGraphics'
  s.requires_arc = true
end
