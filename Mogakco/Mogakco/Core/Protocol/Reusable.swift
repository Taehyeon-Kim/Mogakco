//
//  Reusable.swift
//  Mogakco
//
//  Created by taekki on 2022/11/08.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension UIViewController: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
