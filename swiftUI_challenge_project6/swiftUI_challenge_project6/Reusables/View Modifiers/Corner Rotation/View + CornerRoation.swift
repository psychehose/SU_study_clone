//
//  View + CornerRoation.swift
//  swiftUI_challenge_project6
//
//  Created by psychehose on 2021/01/09.
//

import SwiftUI

extension View {
    
    public func cornerRotation(angle: Angle, anchor: UnitPoint) -> some View {
        self.modifier(CornerRoationModfier (
            angle: angle,
            anchor: anchor
        ))
    }
}
