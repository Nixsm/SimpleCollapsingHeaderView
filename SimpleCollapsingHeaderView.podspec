#
# Be sure to run `pod lib lint SimpleCollapsingHeaderView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SimpleCollapsingHeaderView'
  s.version          = '0.1.0'
  s.summary          = 'An easy to use library for collapsing header views in iOS'

  s.description      = <<-DESC
	An easy to use library to implement a collapsing header view in iOS, that supports simple animations
                       DESC

  s.homepage         = 'https://github.com/nixsm/SimpleCollapsingHeaderView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nixsm' => 'nichsmm@gmail.com' }
  s.source           = { :git => 'https://github.com/nixsm/SimpleCollapsingHeaderView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Nixsm_'

	s.platform = :ios
  s.ios.deployment_target = '9.0'

  s.source_files = 'SimpleCollapsingHeaderView/Classes/**/*'

  s.frameworks = 'UIKit'
end
