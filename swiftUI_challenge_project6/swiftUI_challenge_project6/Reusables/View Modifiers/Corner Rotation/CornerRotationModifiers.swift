//
//  CornerRotationModifiers.swift
//  swiftUI_challenge_project6
//
//  Created by psychehose on 2021/01/09.
//

import SwiftUI

struct CornerRoationModfier: ViewModifier {
    let angle : Angle
    let anchor: UnitPoint
    
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(angle, anchor: anchor)
            .clipped()
        
    }
}
