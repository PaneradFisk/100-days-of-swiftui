//
//  ContentView.swift
//  Animations
//
//  Created by André Bergvall on 2021-02-01.
//

import SwiftUI

struct CornerRotateModifer : ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifer(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifer(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    
    @State private var isShowingRed = false
    
    var body: some View {
        VStack{
            Spacer()
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
//this asymmetric transition is way cooler
//                    .transition(.asymmetric(insertion: .opacity, removal: .scale))
                    .transition(.pivot)
            }
            Spacer()
            Button("Tap me", action: {
                
                withAnimation(){
                    self.isShowingRed.toggle()
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
