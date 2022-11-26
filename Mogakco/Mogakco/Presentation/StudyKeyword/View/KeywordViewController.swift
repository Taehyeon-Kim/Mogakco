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
import RxKeyboard

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
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [unowned self] keyboardHeight in
                let height: CGFloat = keyboardHeight > 0 ? -keyboardHeight + view.safeAreaInsets.bottom : -16
                let padding: CGFloat = keyboardHeight > 0 ? 0 : 16
                let radius: CGFloat = keyboardHeight > 0 ? 0 : 8

                rootView.collectionView.contentInset.bottom = keyboardHeight
                rootView.collectionView.contentOffset.y += keyboardHeight
                rootView.findButton.makeRounded(radius: radius)
                rootView.findButton.snp.updateConstraints {
                    $0.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(padding)
                    $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(height)
                }

                view.layoutIfNeeded()
            })
        .disposed(by: disposeBag)
        
        view.rx.tapGesture()
            .when(.recognized)
            .subscribe { [weak self] _ in
                self?.view.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
}
