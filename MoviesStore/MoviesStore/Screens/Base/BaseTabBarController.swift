//
//  TabBarController.swift
//  MoviesStore
//
//  Created by Hung Hoang on 8/31/22.
//

import UIKit

enum TabItem: String, CaseIterable {

    case home = "home"
    case discover = "discover"
    case search = "search"

    var viewController: UIViewController {
        switch self {
        case .home:
            return HomeViewController()
        case .discover:
            return DiscoverViewController()
        case .search:
            return SearchViewController()
        }

    }

    var tabBarItem: UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: displayTitle,
                image: UIImage(named: "house"),
                selectedImage: UIImage(named: "house.fill"))
        case .discover:
            return UITabBarItem(title: displayTitle,
                image: UIImage(named: "discover"),
                selectedImage: UIImage(named: "magnifyingglass.circle"))
        case .search:
            return UITabBarItem(title: displayTitle,
                image: UIImage(named: "magnifyingglass.circle"),
                selectedImage: UIImage(named: "magnifyingglass.circle"))
        }
    }

    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}

class BaseTabBarController: UITabBarController {

    let tabItems: [TabItem] = [.home, .search]
    var navigationControllers = [UINavigationController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.barTintColor = .clear
        tabBar.backgroundColor = AppColor.primaryColor
        tabBar.layer.backgroundColor = UIColor.clear.cgColor

        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 100)
        blurView.autoresizingMask = .flexibleWidth
        tabBar.insertSubview(blurView, at: 0)

        self.tabBar.tintColor = AppColor.greenColor3
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: AppFont.fontWithStyle(style: .regular, size: 12)], for: .normal)
        
        for item in tabItems {
            let vc = item.viewController
            vc.title = item.displayTitle
            vc.tabBarItem = item.tabBarItem
            let navController = BaseNavigationController(rootViewController: vc)

            navigationControllers.append(navController)
        }

        self.setViewControllers(navigationControllers, animated: false)
    }
}

extension BaseTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return TabTransition(viewControllers: tabBarController.viewControllers)
        }
}


class TabTransition: NSObject, UIViewControllerAnimatedTransitioning {

    let viewControllers: [UIViewController]?
    let transitionDuration: Double = 0.3

    init(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndex(forViewController: toVC)
            else {
                transitionContext.completeTransition(false)
                return
        }

        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart

        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: self.transitionDuration, animations: {
                fromView.frame = fromFrameEnd
                toView.frame = frame
            }, completion: {success in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
        }
    }

    func getIndex(forViewController vc: UIViewController) -> Int? {
        guard let vcs = self.viewControllers else { return nil }
        for (index, thisVC) in vcs.enumerated() {
            if thisVC == vc { return index }
        }
        return nil
    }
}
