#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'window_utils_macos'
  s.version          = '1.0.0'
  s.summary          = 'window utility'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://hello.world'
  s.license          = { :file => '../LICENSE' }
  s.source           = { :path => '.' }
  s.author           = { 'Foo' => 'foo@foo.com' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx
  s.osx.deployment_target = '10.11'
end

