Pod::Spec.new do |s|
  s.name     = 'Common-iOS'
  s.version  = '1.5.2'
  s.platform = :ios
  s.license  = 'MIT'
  s.summary  = 'Common additions to the UIKit and Foundation frameworks used by Power Home iOS projects.'
  s.homepage = 'https://github.com/powerhome/common-ios'
  s.author   = { 'Jeremy Bower' => 'jeremy.bower@powerhrg.com' }
  s.source   = { :git    => 'https://github.com/powerhome/common-ios.git',
                 :tag => s.version.to_s }

  s.requires_arc = true
  s.ios.deployment_target = '8.1'

  s.default_subspec = 'Foundation'

  s.subspec 'Foundation' do |sub|
    sub.source_files = 'Foundation/Classes'
    sub.ios.frameworks = 'Foundation', 'CoreFoundation'
  end

  s.subspec 'UIKit' do |sub|
    sub.source_files = 'UIKit/Classes'
    sub.ios.frameworks = 'UIKit', 'QuartzCore'
    sub.dependency 'Common-iOS/Foundation'
  end

  s.subspec 'MapKit' do |sub|
    sub.source_files = 'MapKit/Classes'
    sub.ios.frameworks = 'MapKit', 'CoreLocation'
    sub.dependency 'Common-iOS/Foundation'
  end
end
