//
//  PulseRingView.swift
//  swiftUI_challenge_project6
//
//  Created by psychehose on 2021/01/09.
//

import SwiftUI

struct PulseRingView: View {
    @State private var scaleDuration: Double = 0.4
    @State private var currentBlurRadius: CGFloat = 0.0
    @State private var buttonScale: CGFloat = 1.0
    @State private var ringOpacity: Double = 1
    @State private var ringScale: CGFloat = 0
    @State private var buttonYRotation: Double = 0.0
}


extension PulseRingView {
    
    var body: some View {
        
        VStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 1.0), {
                    self.buttonYRotation += (2.0 * .pi)
                    //한바퀴 회전..!
                })
            }, label: {
                Text("Tap me")
                    .foregroundColor(.black)
                    .padding(100)
                    .background(Color.accentColor)
                    .clipShape(Circle())
            })
            
            .blur(radius: currentBlurRadius / 3)
            .scaleEffect(buttonScale)
            .animation(.easeOut(duration: scaleDuration))
            .rotation3DEffect(
                .radians(buttonYRotation),
                axis: (x: 0.0, y: 1.0, z: 0.0))
            .overlay(pulseRing)
            .onAppear() {
                self.ringScale = 2
                self.ringOpacity = 0.0
            }
            //Button 끝
            
            VStack {
                Text("Button Scale")
                
                Slider(
                    value: $buttonScale,
                    in: 0.1 ... 1.0,
                    minimumValueLabel: Text("0.1"), maximumValueLabel: Text("1"), label: {
                        Text("Button Scale")
                    })
            }
            .padding()
        }
    }
}

// MARK: - View Variables
extension PulseRingView {
    
    var pulseRing: some View {
        Circle()
            .stroke(Color.accentColor, lineWidth: 4)
            .opacity(ringOpacity)
            .scaleEffect(ringScale)
            .animation(
                Animation
                    .easeOut(duration: 1.0)
                    .repeatForever(autoreverses: false)
            )
    }
}



struct PulseRingView_Previews: PreviewProvider {
    static var previews: some View {
        PulseRingView()
    }
}
