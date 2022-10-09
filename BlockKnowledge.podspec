#
# Be sure to run `pod lib lint BlockKnowledge.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BlockKnowledge'
  s.version          = '0.1.0'
  s.summary          = 'A short description of BlockKnowledge.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  自己积累的关于block基础知识以及用法的事例.
                       DESC

  s.homepage         = 'https://github.com/Andrew5/BlockKnowledge.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jabraknight' => 'localhost3585@gmail.com' }
  s.source           = { :git => 'https://github.com/Andrew5/BlockKnowledge.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'BlockKnowledge/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BlockKnowledge' => ['BlockKnowledge/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
