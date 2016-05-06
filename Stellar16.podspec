Pod::Spec.new do |s|
  s.name         = 'Stellar16'
  s.version      = '1.0.1'
  s.summary      = 'Stellar16 helper library.'
  s.author       = { 'Steven Preston' => 'stevenpreston@stellar16.com' }
  s.source       = { :git => 'https://github.com/stevenpreston/legacy_ios_library.git' }
  s.source_files = 'Stellar16/Classes', 'Stellar16/Classes/**/*.{h,m}'
  s.dependency 'AFNetworking', '2.2.1'
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
  s.ios.frameworks = 'MapKit', 'CoreLocation', 'SystemConfiguration', 'MobileCoreServices'
end