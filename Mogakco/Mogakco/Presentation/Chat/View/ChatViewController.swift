//
//  ChatViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/30.
//

import UIKit

final class ChatViewController: BaseViewController {
    
    private let rootView = ChatView()
    private let viewModel: ChatViewModel
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ChatViewController {
    
}
