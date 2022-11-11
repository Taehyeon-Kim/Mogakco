//
//  BaseViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/07.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {
    
    // MARK: Initialize
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    // MARK: Rx Property
    
    var disposeBag = DisposeBag()
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttributes()
        setHierarchy()
        setLayout()
    }
    
    // MARK: - Override Methods
    
    func setAttributes() {}     // 속성 설정
    func setHierarchy() {}      // 계층 설정
    func setLayout() {}         // 레이아웃 설정
}
