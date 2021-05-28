Pod::Spec.new do |s|
  s.name             = 'IdFramework'
  s.version          = '1.0.1'
  s.summary          = 'This is Idans Framework.'

  s.description      = 'This project contains a framework with usefull functionality'

  s.homepage         = 'https://github.com/idanisra/IdFramework'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'idanisra' => 'idan.israel@gmail.com' }
  s.source           = { :git => 'https://github.com/idanisra/IdFramework.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'
  s.swift_version = '4.2'
  s.static_framework = true
  s.ios.framework  = 'UIKit'
  s.dependency 'FirebaseCore'
  s.dependency 'FirebaseAuth'
  s.dependency 'FirebaseStorage'
  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '/Applications/Xcode.app/Contents/Developer/Library/Frameworks/Fibrease/**' }
  s.source_files = 'IdFramework/Classes/**/*.swift'

end
