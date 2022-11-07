//
//  UIView+Extensions.swift
//  MoviesStore
//
//  Created by Hung Hoang on 9/2/22.
//

import Foundation
import SwiftUI

extension UIView {
    func addSwiftUIView<T:View>(viewControrller: UIViewController ,swiftUIView: T) {
        let childView = UIHostingController(rootView: swiftUIView)
        viewControrller.addChild(childView)
        childView.view.frame = self.bounds
        self.addSubview(childView.view)
        childView.didMove(toParent: viewControrller)

    }
}
