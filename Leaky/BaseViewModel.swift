//
//  BaseViewModel.swift
//  Leaky
//
//  Created by Jacob Bartlett on 14/01/2025.
//

import Foundation

/// Base class for view models in our SwiftUI app.
///
class BaseViewModel: LeakDetectable {
    func track() {
        
    }
    
    init() {
        LeakDetector.shared.check(self)
    }
}
