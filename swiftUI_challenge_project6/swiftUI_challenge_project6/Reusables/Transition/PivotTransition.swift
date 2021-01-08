//
//  PivotTransition.swift
//  swiftUI_challenge_project6
//
//  Created by psychehose on 2021/01/09.
//

import SwiftUI

extension AnyTransition {
    public static var pivot: AnyTransition {
        .modifier(
            active: CornerRoationModfier(
                angle: .radians(-.pi/2),
                anchor: .topLeading),
            identity: CornerRoationModfier(angle: .radians(0), anchor: .topLeading)
        )
    }
    
    
    
}
