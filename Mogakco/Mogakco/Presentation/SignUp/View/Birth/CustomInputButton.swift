//
//  CustomInputButton.swift
//  Mogakco
//
//  Created by taekki on 2022/12/09.
//

import UIKit

final class CustomInputButton: UIButton {
    
    var customInputView: UIView? = UIView()
    var customToolbarView: UIView? = UIView()
    
    override var inputView: UIView? {
        get {
            customInputView
        }
        set {
            customInputView = newValue
            becomeFirstResponder()
        }
    }
    
    override var inputAccessoryView: UIView? {
        get {
            customToolbarView
        }
        set {
            customToolbarView = newValue
        }
    }
    
    override var canBecomeFirstResponder: Bool {
       true
    }
}
