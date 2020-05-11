//
//  ContentView.swift
//  Animations
//
//  Created by Yugantar Jain on 10/05/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

//struct ContentView: View {
//    let letters = Array("Hello SwiftUI")
//    @State private var enabled = false
//    @State private var dragAmount = CGSize.zero
//
//    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(0..<letters.count) { num in
//                Text(String(self.letters[num]))
//                    .padding(5)
//                    .font(.title)
//                    .background(self.enabled ? Color.blue : Color.red)
//                    .offset(self.dragAmount)
//                    .animation(Animation.default.delay(Double(num) / 5))
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged { self.dragAmount = $0.translation }
//                .onEnded { _ in
//                    self.dragAmount = .zero
//                    self.enabled.toggle()
//                }
//        )
//    }
//}

struct ContentView: View {
    @State private var animationAmount = 0.0

    var body: some View {
        Button("Tap Me") {
            withAnimation {
                self.animationAmount += 60
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
