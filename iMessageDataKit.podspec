#
# Be sure to run `pod lib lint iMessageDataKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'iMessageDataKit'
  s.version          = '0.1.0'
  s.summary          = 'Store custom data as key-value pairs in MSMessage objects.'

  s.homepage         = 'https://github.com/svtek/iMessageDataKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ahmet Ardal' => 'ardalahmet@gmail.com' }
  s.source           = { :git => 'https://github.com/svtek/iMessageDataKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/ardalahmet/'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Source/iMessageDataKit/*.swift'

  s.frameworks = 'Messages'
end
