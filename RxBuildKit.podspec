Pod::Spec.new do |s|
  s.name             = 'RxBuildKit'
  s.version          = '0.4.0'
  s.summary          = 'RxBuildKit is an RxSwift wrapper around BuildKit.'
  s.description      = <<-DESC
RxBuildKit is an RxSwift wrapper around BuildKit.
BuildKit is a Swift framework used as a base layer to create iOS Apps. 
It contains base app layer code that I have compiled over time. 
This library can be used to start a new project quickly and cleanly.
                       DESC

  s.homepage         = 'https://github.com/Mackarous/BuildKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrew Mackarous' => 'a.mackarous@gmail.com' }
  s.source           = { :git => 'https://github.com/Mackarous/BuildKit.git', :tag => s.version.to_s }
  s.swift_version    = '5.1'

  s.ios.deployment_target = '11.0'

  s.source_files     = 'RxBuildKit/Classes/**/*'

  s.dependency 'BuildKit'
  s.dependency 'RxSwift'
  
end
