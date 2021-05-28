Pod::Spec.new do |spec|
  spec.name             = 'IdFramework'
  spec.version          = '1.0.0'
  spec.summary          = 'This is Idans Framework.'

  spec.description      = 'This project contains a framework with usefull functionality'

  spec.homepage         = 'https://github.com/idanisra/IdFramework'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'idanisra' => 'idan.israel@gmail.com' }
  
  spec.ios.deployment_target = '12.0'
  spec.swift_version = '4.2'
  spec.source           = { :git => 'https://github.com/idanisra/IdFramework.git', :tag => spec.version.to_s }

  spec.static_framework = true
  spec.ios.framework  = 'UIKit'
  spec.dependency 'FirebaseCore'
  spec.dependency 'FirebaseAuth'
  spec.dependency 'FirebaseStorage'
  spec.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '/Applications/Xcode.app/Contents/Developer/Library/Frameworks/Fibrease/**' }
  spec.source_files = 'IdFramework/Classes/**/*.swift'

end
