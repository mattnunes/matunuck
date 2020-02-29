//
// UIImpactFeedbackGenerator.FeedbackStyle.swift
// Copyright © 2020 Matt Nunes-Spraggs
//


import UIKit

extension UIImpactFeedbackGenerator.FeedbackStyle: UserDefaultsStorable {

    var localizedTitle: String {
        switch self {
        case .light:
            return NSLocalizedString("Light", comment: "UIImpactFeedbackGenerator.FeedbackStyle.light")
        case .medium:
            return NSLocalizedString("Medium", comment: "UIImpactFeedbackGenerator.FeedbackStyle.medium")
        case .heavy:
            return NSLocalizedString("Heavy", comment: "UIImpactFeedbackGenerator.FeedbackStyle.heavy")
        case .soft:
            return NSLocalizedString("Soft", comment: "UIImpactFeedbackGenerator.FeedbackStyle.soft")
        case .rigid:
            return NSLocalizedString("Rigid", comment: "UIImpactFeedbackGenerator.FeedbackStyle.rigid")
        @unknown default:
            fatalError()
        }
    }
    
}
