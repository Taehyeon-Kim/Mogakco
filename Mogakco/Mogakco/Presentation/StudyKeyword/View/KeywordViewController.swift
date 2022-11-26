//
//  KeywordViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/26.
//

import UIKit

import RxCocoa
import RxGesture
import RxSwift

final class KeywordViewController: BaseViewController {
    
    private let rootView = KeywordView()
    private let viewModel = KeywordViewModel()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension KeywordViewController: Bindable {
    
    func bind() {
        let input = KeywordViewModel.Input(
            searchText: rootView.searchBar.rx.text,
            editingDidEndOnExit: rootView.searchBar.searchTextField.rx.controlEvent(.editingDidEndOnExit).asObservable()
        )
        let output = viewModel.transform(input: input)

        output.wantedList
            .bind { keywords in
                print(keywords)
            }
            .disposed(by: disposeBag)
        
        output.resultList
            .bind { results in
                print("내가 하고 싶은", results)
            }
            .disposed(by: disposeBag)
        
        view.rx.tapGesture()
            .when(.recognized)
            .subscribe { [weak self] _ in
                self?.view.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
}
