//
//  DropDownView.swift
//  MoviesStore
//
//  Created by Hung Hoang on 9/3/22.
//

import Foundation
import UIKit

class DropDownButton: UIButton, DropDownProtocol {
    
    var dropView = DropDownView()
    
    private var height = NSLayoutConstraint()
    private var isOpen = false

    func dropDownPressed(string: String) {
        self.setTitle(string, for: .normal)
        self.dismissDropDown()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        let image = UIImage(named: "chevron.down")
        self.setImage(image, for: .normal)

        var filled = UIButton.Configuration.filled()
        filled.imagePadding = 8
        filled.imagePlacement = .trailing
        filled.background.backgroundColor = UIColor.clear
        self.configuration = filled
        
        dropView = DropDownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dropView.delegate = self
        dropView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        self.superview?.bringSubviewToFront(dropView)
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            self.imageView?.rotateUp()

            isOpen = true
            NSLayoutConstraint.deactivate([self.height])
            self.dropView.layoutIfNeeded()
            self.dropView.tableView.reloadData()
            self.dropView.tableView.layoutIfNeeded()
            self.height.constant = self.dropView.tableView.contentSize.height
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }, completion: nil)
            
        } else {
            self.dismissDropDown()
        }
    }
    
    func dismissDropDown() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        self.imageView?.rotateBack()
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
}

protocol DropDownProtocol {
    func dropDownPressed(string : String)
}

extension UIView{
    func rotateUp() {
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(rotationAngle: Double.pi * -3)
        })
    }
    
    func rotateBack() {
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(rotationAngle: 0)
        })
    }
}



class DropDownView: UIView, UITableViewDelegate, UITableViewDataSource  {
    
    let tableView = UITableView()
    
    var options = [String]()
    
    var delegate : DropDownProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        
        tableView.backgroundColor = UIColor.blue
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.estimatedRowHeight = 38
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        tableView.register(UINib(nibName: DropDownCell.nibName(), bundle: nil), forCellReuseIdentifier: DropDownCell.nibName())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DropDownCell.nibName()) as? DropDownCell {
            cell.label.text = options[indexPath.row]
            return cell
        }
        return UITableViewCell.getBaseCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.dropDownPressed(string: options[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
