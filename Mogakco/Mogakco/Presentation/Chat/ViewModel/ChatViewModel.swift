//
//  ChatViewModel.swift
//  Mogakco
//
//  Created by taekki on 2022/11/30.
//

import Foundation

struct ChatViewModel: ViewModelType {
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

extension ChatViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
}

extension ChatViewModel {
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z"
        return dateFormatter
    }
    
    // 날짜 뽑아내는 로직을 ViewModel 단에서 작성해야할까?
    func extractDate(at chats: [Chat]) -> String {
        let defaultDateString = "2000-01-01T00:00:00.000Z"
        
        if chats.isEmpty {
            return defaultDateString
        } else {
            guard let date = chats.last?.date else { return defaultDateString }
            return dateFormatter.string(from: date)
        }
    }
}
