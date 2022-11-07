//
//  UITableViewCellExtension.swift
//  MoviesStore
//
//  Created by Hung Hoang on 8/30/22.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    class func nibName() -> String {
        return String(describing: self)
    }
    
    static func getBaseCell() -> UITableViewCell {
        let cell = UITableViewCell(frame: CGRect.zero)
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    
}

