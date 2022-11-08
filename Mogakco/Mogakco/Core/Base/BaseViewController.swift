//
//  BaseViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/07.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttributes()
        setHierarchy()
        setLayout()
    }
    
    func setAttributes() {}
    func setHierarchy() {}
    func setLayout() {}
}
