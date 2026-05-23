#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint unique_device_identifier.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'unique_device_identifier'
  s.version          = '2.0.5'
  s.summary          = 'A Flutter plugin that provides a unique device identifier.'
  s.description      = <<-DESC
A Flutter plugin that provides a unique device identifier on all platforms
including Android, iOS, Windows, macOS, Linux, and Web.
                       DESC
  s.homepage         = 'https://github.com/jonghoon023/unique_device_identifier'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'jonghoon023' => 'jonghoon023@github.com' }
  s.source           = { :path => '.' }
  s.source_files = 'unique_device_identifier/Sources/unique_device_identifier/**/*.swift'
  s.resource_bundles = {'unique_device_identifier_privacy' => ['unique_device_identifier/Sources/unique_device_identifier/PrivacyInfo.xcprivacy']}
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.9'
end
