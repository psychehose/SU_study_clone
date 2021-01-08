//
//  DraggingGradientExample.swift
//  swiftUI_challenge_project6
//
//  Created by psychehose on 2021/01/09.
//

import SwiftUI

struct DraggingGradientExample: View {
    @State private var dragAmount: CGSize = .zero
//        CGSize(width: 10,height: 15)
}

extension DraggingGradientExample {
    var body: some View {
        rectangleGradient
            .frame(width: 320, height: 240)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged( { dragState in
                        self.dragAmount = dragState.translation
                    })
                    .onEnded( { _ in
                        withAnimation(.spring(), {
                            self.dragAmount = .zero
                        })
                    })
            )
    }
}

extension DraggingGradientExample {
    private var rectangleGradient: some View {
        LinearGradient(
            //gradient의 설정. 색깔 설정
            gradient: Gradient(colors: [Color.red, Color.blue]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
        //스타트 포인트와 엔드포인트.
    }
}








// MARK:- PreView

struct DraggingGradientExample_Previews: PreviewProvider {
    static var previews: some View {
        DraggingGradientExample()
    }
}
