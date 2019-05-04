//
//  FontProvider.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import UIKit

open class FontProvider {
    class func font(size:CGFloat, weight:UIFont.Weight) -> UIFont {
        var fontName = "AppleSDGothicNeo-Regular"
        switch weight {
        case .bold, .heavy:
            fontName = "AppleSDGothicNeo-Bold"
        case .light:
            fontName = "AppleSDGothicNeo-Light"
        case .thin:
            fontName = "AppleSDGothicNeo-Thin"
        case .ultraLight:
            fontName = "AppleSDGothicNeo-UltraLight"
        case .semibold:
            fontName = "AppleSDGothicNeo-SemiBold"
        case .medium:
            fontName = "AppleSDGothicNeo-Medium"
        default:
            fontName = "AppleSDGothicNeo-Regular"
        }
        return UIFont(name: fontName, size: size)!
    }
}

