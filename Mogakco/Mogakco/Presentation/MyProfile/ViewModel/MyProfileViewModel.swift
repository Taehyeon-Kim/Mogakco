//
//  MyProfileViewModel.swift
//  Mogakco
//
//  Created by taekki on 2022/11/21.
//

import UIKit
import RxCocoa
import RxSwift

final class MyProfileViewModel {

    var sections = BehaviorSubject<[MyProfileViewSection]>(value: [])
    
    init() {
        sections.onNext([
            .profile([
                .profile(MyProfileItemCellViewModel(
                    iconImage: .imgProfile,
                    title: UserDefaultsManager.nickname,
                    accessoryImage: .icnMoreArrow,
                    isProfile: true
                ))
            ]),
            .option([
                .notice(MyProfileItemCellViewModel(iconImage: .icnNotice, title: "공지사항")),
                .faq(MyProfileItemCellViewModel(iconImage: .icnFAQ, title: "자주 묻는 질문")),
                .qna(MyProfileItemCellViewModel(iconImage: .icnQNA, title: "1:1 문의")),
                .settingAlarm(MyProfileItemCellViewModel(iconImage: .icnSettingAlarm, title: "알림 설정")),
                .permit(MyProfileItemCellViewModel(iconImage: .icnPermit, title: "이용 약관"))
            ])
        ])
    }
}
