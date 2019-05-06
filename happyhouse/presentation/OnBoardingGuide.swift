//
//  OnBoardingGuide.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import UIKit

enum OnBoardingGuide {
    case first
    case second
    case third
    
    var contentImage: UIImage? {
        switch self {
        case .first:
            return UIImage(named: "onboarding_1")
        case .second:
            return UIImage(named: "onboarding_2")
        case .third:
            return UIImage(named: "onboarding_3")
        }
    }
    
    var descriptionText: String {
        switch self {
        case .first:
            return "해피하우스에 오신 것을 환영합니다\n♡✧。 (⋈◍＞◡＜◍)。✧♡"
        case .second:
            return "그동안 불공평한 집안일 분담에 지치셨나요?\n｡ﾟ(ﾟ´ω`ﾟ)ﾟ｡"
        case .third:
            return "해피하우스에서 공평한 가사분담을 위한\n서비스를 사용해보세요~! ʕ ᵔᴥᵔ ʔ"
        }
    }
    
    var optionalImage: UIImage? {
        switch self {
        case .third:
            return UIImage(named: "onboarding_3_optional")
        default:
            return nil
        }
    }
}

// MARK: - CaseIterable protocol
extension OnBoardingGuide: CaseIterable {}
