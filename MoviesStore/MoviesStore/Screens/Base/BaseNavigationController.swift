//
//  BaseNavigationController.swift
//  MoviesStore
//
//  Created by Hung Hoang on 9/1/22.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //bar
        let titleTextAtributes = [NSAttributedString.Key.font: AppFont.fontWithStyle(style: .bold, size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        let backTextAtributes = [NSAttributedString.Key.font: AppFont.fontWithStyle(style: .regular, size: 18), NSAttributedString.Key.foregroundColor : AppColor.greenColor3]
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        barAppearance.backgroundColor = UIColor.clear
        barAppearance.backgroundEffect = UIBlurEffect(style: .dark)
        barAppearance.backButtonAppearance.normal.titleTextAttributes = backTextAtributes
        barAppearance.titleTextAttributes = titleTextAtributes

        
        let scrollingAppearance = UINavigationBarAppearance()
        scrollingAppearance.configureWithTransparentBackground()
        scrollingAppearance.backgroundColor = AppColor.primaryColor
        scrollingAppearance.titleTextAttributes = titleTextAtributes
        scrollingAppearance.backButtonAppearance.normal.titleTextAttributes = backTextAtributes
        
        navigationBar.tintColor = UIColor.white
        
        navigationBar.standardAppearance = barAppearance
        navigationBar.scrollEdgeAppearance = scrollingAppearance
        navigationBar.compactAppearance = barAppearance
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
