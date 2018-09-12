Pod::Spec.new do |s|
  s.name             = 'BuildKit'
  s.version          = '0.2.1'
  s.summary          = 'BuildKit is a Swift framework used as a base layer to create iOS Apps.'
  s.description      = <<-DESC
BuildKit is a Swift framework used as a base layer to create iOS Apps. 
It contains base app layer code that I have compiled over time. 
This library can be used to start a new project quickly and cleanly.
                       DESC

  s.homepage         = 'https://github.com/Mackarous/BuildKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrew Mackarous' => 'a.mackarous@gmail.com' }
  s.source           = { :git => 'https://github.com/Mackarous/BuildKit.git', :tag => s.version.to_s }
  s.swift_version    = '4.2'
  s.default_subspec  = 'Core'

  s.ios.deployment_target = '11.0'

#  s.source_files = 'BuildKit/Classes/**/*'

  s.subspec 'Core' do |c|
    c.source_files = 'BuildKit/Classes/**/*'
  end

end
