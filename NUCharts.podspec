#
# Be sure to run `pod lib lint NUCharts.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NUCharts'
  s.version          = '0.2.7'
  s.summary          = 'A simple charts library that supports fancy animations.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  A simple charts library that supports fancy animations.
                       DESC

  s.homepage         = 'https://github.com/nubank/NUCharts'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Victor' => 'vgm.maraccini@gmail.com' }
  s.source           = { :git => 'git@github.com:nubank/NUCharts.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'NUCharts/Classes/**/*'

end
