# SPImageFilter

![swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![pod](https://img.shields.io/badge/pod-1.0-blue)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


The Simplest way to use image filter 🎨

# How to use

## Default
```swift
let image: UIImage = UIImage(name: "example")?.spFilter(type: .ciBoxBlur, options: [
        "inputRadius" : 10
    ]).output
```

## Filter Chaining
```swift
let image: UIImage = UIImage(name: "example")?
    .spFilter(type: .ciBoxBlur, options: [
        "inputRadius" : 10
    ])
    .spFilter(type: .ciGaussianBlur, options: [
        "inputRadius" : 10
    ]).output
```

# Installation
## CocoaPods
```ruby
pod 'SPImageFilter'
```

# Documentation

<a href="https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html">Core Image Filter Reference</a>