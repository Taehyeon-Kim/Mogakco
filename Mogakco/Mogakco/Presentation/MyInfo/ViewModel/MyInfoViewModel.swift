//
//  MyInfoViewModel.swift
//  Mogakco
//
//  Created by taekki on 2022/11/21.
//

import UIKit
import RxCocoa
import RxSwift

final class MyInfoViewModel {

    var sections = BehaviorSubject<[MyInfoViewSection]>(value: [])
    
    init() {
        sections.onNext([
            .profile([
                .profile(MyInfoItemCellViewModel(
                    iconImage: .imgProfile,
                    title: UserDefaultsManager.nickname,
                    accessoryImage: .icnMoreArrow,
                    isProfile: true
                ))
            ]),
            .option([
                .notice(MyInfoItemCellViewModel(iconImage: .icnNotice, title: "공지사항")),
                .faq(MyInfoItemCellViewModel(iconImage: .icnFAQ, title: "자주 묻는 질문")),
                .qna(MyInfoItemCellViewModel(iconImage: .icnQNA, title: "1:1 문의")),
                .settingAlarm(MyInfoItemCellViewModel(iconImage: .icnSettingAlarm, title: "알림 설정")),
                .permit(MyInfoItemCellViewModel(iconImage: .icnPermit, title: "이용 약관"))
            ])
        ])
    }
}
