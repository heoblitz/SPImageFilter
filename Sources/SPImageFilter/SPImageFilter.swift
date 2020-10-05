//
//  SPImageFilter.swift
//  SPImageFilter
//
//  Created by won heo on 2020/09/28.
//

import UIKit

public protocol SPImageFilter {}

extension SPImageFilter where Self: UIImage {
    
    @inlinable
    public func spFilter(type: SPImageFilterType, options: [String:Any]) -> CIImage {
        guard let filter: CIFilter = CIFilter(name: type.rawValue) else {
            NSLog("SPImageFilter - Create CIFilter Failed")
            return CIImage()
        }
        
        guard let ciImage: CIImage = CIImage(image: self) else {
            NSLog("SPImageFilter - Convert UIImage to CIImage Failed")
            return CIImage()
        }
        
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        options.forEach { option in
            filter.setValue(option.value, forKey: option.key)
        }
        
        guard let outputImage: CIImage = filter.outputImage else {
            NSLog("SPImageFilter - Create CIImage Failed")
            return CIImage()
        }
        
        return outputImage
    }
}

extension SPImageFilter where Self: CIImage {
    
    @inlinable
    public func spFilter(type: SPImageFilterType, options: [String:Any]) -> CIImage {
        return self.applyingFilter(type.rawValue, parameters: options)
    }
    
    public var output: UIImage? {
        get {
            guard let cgImage: CGImage = SPImageContext.ciContext.createCGImage(self, from: self.extent) else {
                NSLog("SPImageFilter - Create CGImage Failed")
                return nil
            }
            
            return UIImage(cgImage: cgImage)
        }
    }
}

extension UIImage: SPImageFilter {}
extension CIImage: SPImageFilter {}
