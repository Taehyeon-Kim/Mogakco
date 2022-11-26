//
//  Images.swift
//  Mogakco
//
//  Created by taekki on 2022/11/07.
//

import UIKit

extension UIImage {
    
    func resized(width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return renderImage
    }
    
    func resized(side: CGFloat) -> UIImage {
        return self.resized(width: side, height: side)
    }
}

extension UIImage {
    
    // Splash
    static var imgSplashLogo: UIImage? { return UIImage(named: "splash_logo") }
    static var imgSplashText: UIImage? { return UIImage(named: "txt") }
    
    // Size16
    static var icnBadge: UIImage? { return UIImage(named: "badge") }
    static var icnBell: UIImage? { return UIImage(named: "bell") }
    static var icnCheck: UIImage? { return UIImage(named: "check") }
    static var icnCloseSmall: UIImage? { return UIImage(named: "close_small") }
    static var icnMoreArrow: UIImage? { return UIImage(named: "more_arrow") }
    
    // Size24
    static var icnArrow: UIImage? { return UIImage(named: "arrow") }
    static var icnCancelMatch: UIImage? { return UIImage(named: "cancel_match") }
    static var icnCloseBig: UIImage? { return UIImage(named: "close_big") }
    static var icnFAQ: UIImage? { return UIImage(named: "faq") }
    static var icnFilterControl: UIImage? { return UIImage(named: "filter_control") }
    static var icnFriendsPlus: UIImage? { return UIImage(named: "friends_plus") }
    static var icnLogout: UIImage? { return UIImage(named: "logout") }
    static var icnMessage: UIImage? { return UIImage(named: "message") }
    static var icnMore: UIImage? { return UIImage(named: "more") }
    static var icnNotice: UIImage? { return UIImage(named: "notice") }
    static var icnPermit: UIImage? { return UIImage(named: "permit") }
    static var icnPlace: UIImage? { return UIImage(named: "place") }
    static var icnPlus: UIImage? { return UIImage(named: "plus") }
    static var icnQNA: UIImage? { return UIImage(named: "qna") }
    static var icnSearch: UIImage? { return UIImage(named: "search") }
    static var icnSettingAlarm: UIImage? { return UIImage(named: "setting_alarm") }
    static var icnSiren: UIImage? { return UIImage(named: "siren") }
    static var icnWrite: UIImage? { return UIImage(named: "write") }
    
    // Size 40
    static var icnAntenna: UIImage? { return UIImage(named: "antenna") }
    
    // Size 48
    static var icnMapMarker: UIImage? { return UIImage(named: "map_marker") }
    
    // Size 64
    static var icnMan: UIImage? { return UIImage(named: "man") }
    static var icnWoman: UIImage? { return UIImage(named: "woman") }
    static var icnSesac: UIImage? { return UIImage(named: "sesac") }
    
    // Onboarding
    static var imgOnboarding1: UIImage? { return UIImage(named: "onboarding_img1") }
    static var imgOnboarding2: UIImage? { return UIImage(named: "onboarding_img2") }
    static var imgOnboarding3: UIImage? { return UIImage(named: "onboarding_img3") }
    
    // MyInfo
    static var imgProfile: UIImage? { return UIImage(named: "profile_img") }
    
    // Tab
    static var icnTabFriendActive: UIImage? { return UIImage(named: "friend.active") }
    static var icnTabFriendInactive: UIImage? { return UIImage(named: "friend.inactive") }
    static var icnTabHomeActive: UIImage? { return UIImage(named: "home.active") }
    static var icnTabHomeInactive: UIImage? { return UIImage(named: "home.inactive") }
    static var icnTabProfileActive: UIImage? { return UIImage(named: "profile.active") }
    static var icnTabProfileInactive: UIImage? { return UIImage(named: "profile.inactive") }
    static var icnTabShopActive: UIImage? { return UIImage(named: "shop.active") }
    static var icnTabShopInactive: UIImage? { return UIImage(named: "shop.inactive") }
}
