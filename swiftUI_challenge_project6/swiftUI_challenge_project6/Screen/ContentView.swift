//
//  ContentView.swift
//  swiftUI_challenge_project6
//
//  Created by psychehose on 2021/01/09.
//

import SwiftUI

struct ContentView: View {
}
extension ContentView {
    var body: some View {
        
        NavigationView {
            List {
                NavigationLink(destination: PulseRingView()) {
                    Text("Pulse Ring")
                }
                NavigationLink(destination: DraggingGradientExample()) {
                    Text("Draggable Gradient")
                }
                NavigationLink(destination: SnakyLettersExample()) {
                    Text("Snaky Letters")
                }
                NavigationLink(destination: VisibilityTransitionExample()) {
                    Text("Show/Hide View Transitions")
                }
                NavigationLink(destination: CornerRotationExample()) {
                    Text("Custom Rotation View Modifier")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .accentColor(.yellow)
    }
}
