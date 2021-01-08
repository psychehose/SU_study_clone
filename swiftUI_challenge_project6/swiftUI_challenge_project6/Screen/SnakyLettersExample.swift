//
//  SnakyLettersExample.swift
//  swiftUI_challenge_project6
//
//  Created by psychehose on 2021/01/09.
//

import SwiftUI

struct SnakyLettersExample: View {
    private let letters = Array("ANIMATION")
    @State private var letterBoxColor: Color = .orange
    @State private var dragOffset: CGSize = .zero
}
extension SnakyLettersExample {
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(0 ..< letters.count) { index in
                Text(String(self.letters[index]))
                    .padding()
                    .font(.headline)
                    .background(self.letterBoxColor)
                    .offset(self.dragOffset)
                    .animation(
                        Animation
                            .easeOut(duration: 0.5)
                            .delay(0.1 * Double(index))
                    )
                //Text End
            }
        }
        .gesture(
            DragGesture()
                .onChanged( { dragState in
                    self.dragOffset = dragState.translation
                })
                .onEnded( { _ in
                    self.dragOffset = .zero
                    self.letterBoxColor = self.letterBoxColor == .purple ? .orange : .purple
                })
        )
    }
}

struct SnakyLettersExample_Previews: PreviewProvider {
    static var previews: some View {
        SnakyLettersExample()
    }
}
