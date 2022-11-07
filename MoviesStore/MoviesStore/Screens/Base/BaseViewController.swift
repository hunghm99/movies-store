//
//  BaseViewController.swift
//  MoviesStore
//
//  Created by Hung Hoang on 8/31/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchButton = UIButton(type:.system)
        searchButton.setImage(UIImage(named: "magnifyingglass"), for:.normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: searchButton)]

    }
    
    @objc func searchButtonClicked() {
        let vc = SearchViewController.initWithNib()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
