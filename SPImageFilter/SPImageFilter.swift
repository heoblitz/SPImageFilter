//
//  SPImageFilter.swift
//  SPImageFilter
//
//  Created by won heo on 2020/09/28.
//

import UIKit

public struct SPImageContext {
    static let ciContext: CIContext = CIContext(options: nil)
}

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

public enum SPImageFilterType: String {
    case ciBoxBlur = "CIBoxBlur"
    case ciDiscBlur = "CIDiscBlur"
    case ciGaussianBlur = "CIGaussianBlur"
    case ciMaskedVariableBlur = "CIMaskedVariableBlur"
    case ciMedianFilter = "CIMedianFilter"
    case ciMotionBlur = "CIMotionBlur"
    case ciNoiseReduction = "CINoiseReduction"
    case ciZoomBlur = "CIZoomBlur"
    case ciColorClamp = "CIColorClamp"
    case ciColorControls = "CIColorControls"
    case ciColorMatrix = "CIColorMatrix"
    case ciColorPolynomial = "CIColorPolynomial"
    case ciExposureAdjust = "CIExposureAdjust"
    case ciGammaAdjust = "CIGammaAdjust"
    case ciHueAdjust = "CIHueAdjust"
    case ciLinearToSRGBToneCurve = "CILinearToSRGBToneCurve"
    case ciSRGBToneCurveToLinear = "CISRGBToneCurveToLinear"
    case ciTemperatureAndTint = "CITemperatureAndTint"
    case ciToneCurve = "CIToneCurve"
    case ciVibrance = "CIVibrance"
    case ciWhitePointAdjust = "CIWhitePointAdjust"
    case ciColorCrossPolynomial = "CIColorCrossPolynomial"
    case ciColorCube = "CIColorCube"
    case ciColorCubeWithColorSpace = "CIColorCubeWithColorSpace"
    case ciColorInvert = "CIColorInvert"
    case ciColorMap = "CIColorMap"
    case ciColorMonochrome = "CIColorMonochrome"
    case ciColorPosterize = "CIColorPosterize"
    case ciFalseColor = "CIFalseColor"
    case ciMaskToAlpha = "CIMaskToAlpha"
    case ciMaximumComponent = "CIMaximumComponent"
    case ciMinimumComponent = "CIMinimumComponent"
    case ciPhotoEffectChrome = "CIPhotoEffectChrome"
    case ciPhotoEffectFade = "CIPhotoEffectFade"
    case ciPhotoEffectInstant = "CIPhotoEffectInstant"
    case ciPhotoEffectMono = "CIPhotoEffectMono"
    case ciPhotoEffectNoir = "CIPhotoEffectNoir"
    case ciPhotoEffectProcess = "CIPhotoEffectProcess"
    case ciPhotoEffectTonal = "CIPhotoEffectTonal"
    case ciPhotoEffectTransfer = "CIPhotoEffectTransfer"
    case ciSepiaTone = "CISepiaTone"
    case ciVignette = "CIVignette"
    case ciVignetteEffect = "CIVignetteEffect"
    case ciAdditionCompositing = "CIAdditionCompositing"
    case ciColorBlendMode = "CIColorBlendMode"
    case ciColorBurnBlendMode = "CIColorBurnBlendMode"
    case ciColorDodgeBlendMode = "CIColorDodgeBlendMode"
    case ciDarkenBlendMode = "CIDarkenBlendMode"
    case ciDifferenceBlendMode = "CIDifferenceBlendMode"
    case ciDivideBlendMode = "CIDivideBlendMode"
    case ciExclusionBlendMode = "CIExclusionBlendMode"
    case ciHardLightBlendMode = "CIHardLightBlendMode"
    case ciHueBlendMode = "CIHueBlendMode"
    case ciLightenBlendMode = "CILightenBlendMode"
    case ciLinearBurnBlendMode = "CILinearBurnBlendMode"
    case ciLinearDodgeBlendMode = "CILinearDodgeBlendMode"
    case ciLuminosityBlendMode = "CILuminosityBlendMode"
    case ciMaximumCompositing = "CIMaximumCompositing"
    case ciMinimumCompositing = "CIMinimumCompositing"
    case ciMultiplyBlendMode = "CIMultiplyBlendMode"
    case ciMultiplyCompositing = "CIMultiplyCompositing"
    case ciOverlayBlendMode = "CIOverlayBlendMode"
    case ciPinLightBlendMode = "CIPinLightBlendMode"
    case ciSaturationBlendMode = "CISaturationBlendMode"
    case ciScreenBlendMode = "CIScreenBlendMode"
    case ciSoftLightBlendMode = "CISoftLightBlendMode"
    case ciSourceAtopCompositing = "CISourceAtopCompositing"
    case ciSourceInCompositing = "CISourceInCompositing"
    case ciSourceOutCompositing = "CISourceOutCompositing"
    case ciSourceOverCompositing = "CISourceOverCompositing"
    case ciSubtractBlendMode = "CISubtractBlendMode"
    case ciBumpDistortion = "CIBumpDistortion"
    case ciBumpDistortionLinear = "CIBumpDistortionLinear"
    case ciCircleSplashDistortion = "CICircleSplashDistortion"
    case ciCircularWrap = "CICircularWrap"
    case ciDroste = "CIDroste"
    case ciDisplacementDistortion = "CIDisplacementDistortion"
    case ciGlassDistortion = "CIGlassDistortion"
    case ciGlassLozenge = "CIGlassLozenge"
    case ciHoleDistortion = "CIHoleDistortion"
    case ciLightTunnel = "CILightTunnel"
    case ciPinchDistortion = "CIPinchDistortion"
    case ciStretchCrop = "CIStretchCrop"
    case ciTorusLensDistortion = "CITorusLensDistortion"
    case ciTwirlDistortion = "CITwirlDistortion"
    case ciVortexDistortion = "CIVortexDistortion"
    case ciAztecCodeGenerator = "CIAztecCodeGenerator"
    case ciCheckerboardGenerator = "CICheckerboardGenerator"
    case ciCode128BarcodeGenerator = "CICode128BarcodeGenerator"
    case ciConstantColorGenerator = "CIConstantColorGenerator"
    case ciLenticularHaloGenerator = "CILenticularHaloGenerator"
    case ciPDF417BarcodeGenerator = "CIPDF417BarcodeGenerator"
    case ciQRCodeGenerator = "CIQRCodeGenerator"
    case ciRandomGenerator = "CIRandomGenerator"
    case ciStarShineGenerator = "CIStarShineGenerator"
    case ciStripesGenerator = "CIStripesGenerator"
    case ciSunbeamsGenerator = "CISunbeamsGenerator"
    case ciAffineTransform = "CIAffineTransform"
    case ciCrop = "CICrop"
    case ciLanczosScaleTransform = "CILanczosScaleTransform"
    case ciPerspectiveCorrection = "CIPerspectiveCorrection"
    case ciPerspectiveTransform = "CIPerspectiveTransform"
    case ciPerspectiveTransformWithExtent = "CIPerspectiveTransformWithExtent"
    case ciStraightenFilter = "CIStraightenFilter"
    case ciGaussianGradient = "CIGaussianGradient"
    case ciLinearGradient = "CILinearGradient"
    case ciRadialGradient = "CIRadialGradient"
    case ciSmoothLinearGradient = "CISmoothLinearGradient"
    case ciCircularScreen = "CICircularScreen"
    case ciCMYKHalftone = "CICMYKHalftone"
    case ciDotScreen = "CIDotScreen"
    case ciHatchedScreen = "CIHatchedScreen"
    case ciLineScreen = "CILineScreen"
    case ciAreaAverage = "CIAreaAverage"
    case ciAreaHistogram = "CIAreaHistogram"
    case ciRowAverage = "CIRowAverage"
    case ciColumnAverage = "CIColumnAverage"
    case ciHistogramDisplayFilter = "CIHistogramDisplayFilter"
    case ciAreaMaximum = "CIAreaMaximum"
    case ciAreaMinimum = "CIAreaMinimum"
    case ciAreaMaximumAlpha = "CIAreaMaximumAlpha"
    case ciAreaMinimumAlpha = "CIAreaMinimumAlpha"
    case ciSharpenLuminance = "CISharpenLuminance"
    case ciUnsharpMask = "CIUnsharpMask"
    case ciBlendWithAlphaMask = "CIBlendWithAlphaMask"
    case ciBlendWithMask = "CIBlendWithMask"
    case ciBloom = "CIBloom"
    case ciComicEffect = "CIComicEffect"
    case ciConvolution3X3 = "CIConvolution3X3"
    case ciConvolution5X5 = "CIConvolution5X5"
    case ciConvolution7X7 = "CIConvolution7X7"
    case ciConvolution9Horizontal = "CIConvolution9Horizontal"
    case ciConvolution9Vertical = "CIConvolution9Vertical"
    case ciCrystallize = "CICrystallize"
    case ciDepthOfField = "CIDepthOfField"
    case ciEdges = "CIEdges"
    case ciEdgeWork = "CIEdgeWork"
    case ciGloom = "CIGloom"
    case ciHeightFieldFromMask = "CIHeightFieldFromMask"
    case ciHexagonalPixellate = "CIHexagonalPixellate"
    case ciHighlightShadowAdjust = "CIHighlightShadowAdjust"
    case ciLineOverlay = "CILineOverlay"
    case ciPixellate = "CIPixellate"
    case ciPointillize = "CIPointillize"
    case ciShadedMaterial = "CIShadedMaterial"
    case ciSpotColor = "CISpotColor"
    case ciSpotLight = "CISpotLight"
    case ciAffineClamp = "CIAffineClamp"
    case ciAffineTile = "CIAffineTile"
    case ciEightfoldReflectedTile = "CIEightfoldReflectedTile"
    case ciFourfoldReflectedTile = "CIFourfoldReflectedTile"
    case ciFourfoldRotatedTile = "CIFourfoldRotatedTile"
    case ciFourfoldTranslatedTile = "CIFourfoldTranslatedTile"
    case ciGlideReflectedTile = "CIGlideReflectedTile"
    case ciKaleidoscope = "CIKaleidoscope"
    case ciOpTile = "CIOpTile"
    case ciParallelogramTile = "CIParallelogramTile"
    case ciPerspectiveTile = "CIPerspectiveTile"
    case ciSixfoldReflectedTile = "CISixfoldReflectedTile"
    case ciSixfoldRotatedTile = "CISixfoldRotatedTile"
    case ciTriangleKaleidoscope = "CITriangleKaleidoscope"
    case ciTriangleTile = "CITriangleTile"
    case ciTwelvefoldReflectedTile = "CITwelvefoldReflectedTile"
    case ciAccordionFoldTransition = "CIAccordionFoldTransition"
    case ciBarsSwipeTransition = "CIBarsSwipeTransition"
    case ciCopyMachineTransition = "CICopyMachineTransition"
    case ciDisintegrateWithMaskTransition = "CIDisintegrateWithMaskTransition"
    case ciDissolveTransition = "CIDissolveTransition"
    case ciFlashTransition = "CIFlashTransition"
    case ciModTransition = "CIModTransition"
    case ciPageCurlTransition = "CIPageCurlTransition"
    case ciPageCurlWithShadowTransition = "CIPageCurlWithShadowTransition"
    case ciRippleTransition = "CIRippleTransition"
    case ciSwipeTransition = "CISwipeTransition"
}
