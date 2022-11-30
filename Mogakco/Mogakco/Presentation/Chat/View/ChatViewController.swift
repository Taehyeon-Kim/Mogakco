//
//  ChatViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/30.
//

import UIKit

final class ChatViewController: BaseViewController {
    
    let rootView = ChatView()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .MGC.white
    }
}

extension ChatViewController {
    
}
