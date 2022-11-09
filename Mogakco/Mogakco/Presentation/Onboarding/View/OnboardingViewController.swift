//
//  OnboardingViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/07.
//

import UIKit

final class OnboardingViewController: BaseViewController {

    private let rootView = OnboardingView()
    
    override func loadView() {
        self.view = rootView
    }
}
