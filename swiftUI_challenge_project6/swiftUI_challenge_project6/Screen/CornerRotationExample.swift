//
//  CornerRotationExample.swift
//  swiftUI_challenge_project6
//
//  Created by psychehose on 2021/01/09.
//

import SwiftUI

struct CornerRotationExample: View {
    @State private var isShowingRectangle = true
    
}

extension CornerRotationExample {
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.4), {
                    self.isShowingRectangle.toggle()
                })
            }, label: {
                Text("Tap me")
                    .font(.largeTitle)
            })
            
            if isShowingRectangle {
                Rectangle()
                    .fill(Color.blue)
                    .transition(.pivot)
            }
        }
    }
}
struct CornerRotationExample_Previews: PreviewProvider {
    static var previews: some View {
        CornerRotationExample()
    }
}
