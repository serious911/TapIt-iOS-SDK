Pod::Spec.new do |s|
  s.name         = 'TapIt'
  s.version      = '3.1.5'
  s.summary      = "The TapIt Advertising SDK for iOS"
  s.homepage     = "http://www.tapit.com"
  s.author       = { 'Phunware, Inc.' => 'http://www.phunware.com' }
  s.social_media_url = 'https://twitter.com/Phunware'

  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/tapit/TapIt-iOS-SDK.git", :tag => 'v3.1.5' }
  s.license      = { :type => 'Copyright', :text => 'Copyright 2015 by Phunware Inc. All rights reserved.' }

  s.public_header_files = 'Framework/TapIt.framework/Versions/A/Headers/*.h'
  s.ios.vendored_frameworks = 'Framework/TapIt.framework'
  s.resource  = 'Framework/TapIt.bundle'

  s.xcconfig      = { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/TapIt/**"'}
  s.ios.frameworks = 'Security', 'QuartzCore', 'SystemConfiguration', 'MobileCoreServices', 'CoreTelephony', 'MessageUI', 'EventKit', 'EventKitUI', 'CoreMedia', 'AVFoundation', 'MediaPlayer', 'AudioToolbox', 'AdSupport', 'StoreKit'
  s.requires_arc = true
end
