//
//  VisibilityTransitionExample.swift
//  swiftUI_challenge_project6
//
//  Created by psychehose on 2021/01/09.
//

import SwiftUI

struct VisibilityTransitionExample: View {
    @State private var isShowingSquare = false
}
extension VisibilityTransitionExample {
    var body: some View {
        
        VStack {
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.4), {
                    self.isShowingSquare.toggle()
                })
            }, label: {
                Text("Tap me")
                    .font(.largeTitle)
            })
            
            if isShowingSquare {
                Rectangle()
                    .fill(Color.pink)
                    .frame(width: 200, height: 200,alignment: .center)
                    .transition(
                        .asymmetric(insertion: .scale, removal: .scale))
            }
            
        }
        
        
    }
}

struct VisibilityTransitionExample_Previews: PreviewProvider {
    static var previews: some View {
        VisibilityTransitionExample()
    }
}
