//
// UISegmentedControl.swift
// Copyright © 2020 Matt Nunes-Spraggs
//


import UIKit

extension UISegmentedControl {
    
    func setTitles(_ items: [String]) {
        removeAllSegments()
        items.forEach { item in
            insertSegment(withTitle: item, at: numberOfSegments, animated: false)
        }
    }
    
}
