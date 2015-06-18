Pod::Spec.new do |s|
  s.name     = 'BowerLabs'
  s.version  = '1.3.0'
  s.platform = :ios
  s.license  = 'MIT'
  s.summary  = 'Common frameworks used by Bower Labs projects.'
  s.homepage = 'https://github.com/bowerlabs/BowerLabs-Common-iOS'
  s.author   = { 'Jeremy Bower' => 'jeremy@bowerlabs.com' }
  s.source   = { :git    => 'https://github.com/bowerlabs/BowerLabs-Common-iOS.git',
                 :tag => s.version.to_s }
                 
  s.requires_arc = true
  s.ios.deployment_target = '8.3'
  
  s.default_subspec = 'Foundation'

  s.subspec 'Foundation' do |sub|
    sub.source_files = 'Foundation/Classes'
    sub.ios.frameworks = 'Foundation', 'CoreFoundation'
  end
  
  s.subspec 'UIKit' do |sub|
    sub.source_files = 'UIKit/Classes'
    sub.ios.frameworks = 'UIKit', 'QuartzCore'
    sub.dependency 'BowerLabs/Foundation'
  end
  
  s.subspec 'MapKit' do |sub|
    sub.source_files = 'MapKit/Classes'
    sub.ios.frameworks = 'MapKit', 'CoreLocation'
    sub.dependency 'BowerLabs/Foundation'
  end
end