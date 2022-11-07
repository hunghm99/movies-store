//
//  UIViewController+Extensions.swift
//  MoviesStore
//
//  Created by Hung Hoang on 9/1/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func initWithNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
}
