//
//  ViewController.swift
//  MoviesStore
//
//  Created by Hung Hoang on 8/30/22.
//

import UIKit
import SwiftUI

class HomeViewController: BaseViewController {
    var button = DropDownButton()
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let moviesListView = MoviesListView()
        listView.addSwiftUIView(viewControrller: self, swiftUIView: moviesListView)
        scrollView.delegate = self
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 300)
        
        //kind of movies drop down
        let options =  ["Popular Movies","Top Rated Movies", "Upcoming Movies"]
        
        let dropDownButton = DropDownButton(frame: CGRect(x: 8, y: listView.frame.origin.y - 30 - 8, width: 190, height: 30))
        dropDownButton.setTitle(options.first, for: .normal)
        self.scrollView.addSubview(dropDownButton)
        dropDownButton.dropView.options = options
    }
    @IBAction func showAll(_ sender: Any) {
        let vc = DiscoverViewController.initWithNib()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pan = scrollView.panGestureRecognizer
        let velocity = pan.velocity(in: scrollView).y
        if velocity < -5 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else if velocity > 5 {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}

