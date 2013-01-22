Pod::Spec.new do |s|
  s.name     = 'BowerLabsFoundation'
  s.version  = '1.0.2'
  s.platform = :ios
  s.license  = 'MIT'
  s.summary  = 'Common additions to the Foundation and CoreFoundation frameworks used by many Bower Labs projects.'
  s.homepage = 'https://github.com/bowerlabs/BowerLabs-Foundation-iOS'
  s.author   = { 'Jeremy Bower' => 'jeremy@jeremybower.com' }
  s.source   = { :git    => 'https://github.com/bowerlabs/BowerLabs-Foundation-iOS.git',
                 :tag => '1.0.2' }

  s.source_files = 'BowerLabsFoundation/Classes'

  s.ios.deployment_target = '5.0'
  s.ios.frameworks = 'Foundation', 'CoreFoundation'
end