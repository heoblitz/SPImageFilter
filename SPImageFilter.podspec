Pod::Spec.new do |spec|
    spec.name             = "SPImageFilter"
    spec.version          = "0.0.2"
    spec.summary          = "The Simplest way to use image filter"
    spec.homepage         = "https://github.com/heoblitz/SPImageFilter"
    spec.license          = "MIT"
    spec.author           = { "Heo Won" => "qndlf22@naver.com" }
    spec.source           = { :git => "https://github.com/heoblitz/SPImageFilter.git",
                           :tag => spec.version.to_s }
    spec.source_files     = "Sources/SPImageFilter/*.swift"
    spec.requires_arc     = true
  
    spec.swift_version = "5.0"
    spec.ios.deployment_target = "9.0"
end
