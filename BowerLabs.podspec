Pod::Spec.new do |s|
  s.name     = 'BowerLabs'
  s.version  = '1.0.3'
  s.platform = :ios
  s.license  = 'MIT'
  s.summary  = 'Common frameworks used by many Bower Labs projects.'
  s.homepage = 'https://github.com/bowerlabs/BowerLabs-Common-iOS'
  s.author   = { 'Jeremy Bower' => 'jeremy@jeremybower.com' }
  s.source   = { :git    => 'https://github.com/bowerlabs/BowerLabs-Common-iOS.git',
                 :tag => "#{s.version}" }
                 
  s.requires_arc = true
  s.ios.deployment_target = '5.0'
  
  s.preferred_dependency = 'Foundation'
  
  s.subspec 'Foundation' do |foundation|
    foundation.source_files = 'Foundation/Classes'
    foundation.ios.frameworks = 'Foundation', 'CoreFoundation'
  end
  
  s.subspec 'UIKit' do |uikit|
    uikit.source_files = 'UIKit/Classes'
    uikit.ios.frameworks = 'UIKit', 'QuartzCore'
    uikit.dependency 'BowerLabs/Foundation'
  end
end