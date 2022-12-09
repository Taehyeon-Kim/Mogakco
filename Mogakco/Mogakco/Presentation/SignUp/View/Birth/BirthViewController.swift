//
//  BirthViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift

final class BirthViewController: BaseViewController {

    // MARK: UI
    private let rootView = BirthRootView()
    
    // MARK: Properties
    var viewModel: BirthViewModel
    
    // MARK: Initializing
    init(viewModel: BirthViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Life Cycle
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

// MARK: - Binding
extension BirthViewController: Bindable {
    
    func bind() {}
}

// MARK: - Transition
extension BirthViewController {

    private func transition(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
