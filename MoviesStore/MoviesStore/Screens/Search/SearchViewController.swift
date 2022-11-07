//
//  SearchViewController.swift
//  MoviesStore
//
//  Created by Hung Hoang on 8/31/22.
//

import UIKit
import SwiftUI

class SearchViewController: UIViewController {
    
    var searchTextField: UITextField = UITextField()
    let clearButton = UIButton(type: .custom)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTextField()
    }
    
    func setUpTextField() {
        
        let width = UIScreen.main.bounds.width - 100
        searchTextField.frame = CGRect(x: 0, y: 0, width: width, height: 34)
        searchTextField.autocorrectionType = .no
        searchTextField.placeholder = "Enter movie title"
        searchTextField.placeHolderColor = UIColor.white.withAlphaComponent(0.4)
        searchTextField.tintColor = AppColor.greenColor3
        searchTextField.textAlignment = .center
        searchTextField.textColor = .white
        searchTextField.font = AppFont.fontWithStyle(style: .regular, size: 16.0)
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        
        clearButton.setImage(UIImage(named: "xmark.circle.fill"), for: .normal)
        clearButton.tintColor = AppColor.greenColor3
        clearButton.frame = CGRect(x: 0, y: 10, width: 24, height: 24)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(handleClearText), for: .touchUpInside)
        clearButton.isHidden = true
        searchTextField.rightView = clearButton
        searchTextField.rightViewMode = .whileEditing
        searchTextField.returnKeyType = .search
        
        navigationItem.titleView = searchTextField
    }
    
    @objc func handleClearText() {
        searchTextField.text = ""
        clearButton.isHidden = true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        clearButton.isHidden = false
    }

}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UITextField {
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(
                string: self.placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: newValue!]
            )
        }
    }
}
