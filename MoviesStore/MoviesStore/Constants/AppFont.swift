//
//  AppFont.swift
//  MoviesStore
//
//  Created by Hung Hoang on 8/30/22.
//

import UIKit


enum AppFontStyle {
    case regular
    case light
    case bold
    case semibold
    
    func fontName() -> String {
        switch self {
        case .bold:
            return "SourceSansPro-Semibold"
        case .light:
            return "Inter-Light"
        case .regular:
            return "SourceSansPro-Regular"
        case .semibold:
            return "Inter-SemiBold"
        }
    }
}

class AppFont: NSObject {
    class func fontWithStyle(style: AppFontStyle, size: CGFloat) -> UIFont {
        if let font = UIFont(name: style.fontName(), size: size) {
            return font
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}

