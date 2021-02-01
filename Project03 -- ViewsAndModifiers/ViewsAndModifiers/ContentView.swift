//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by André Bergvall on 2021-01-18.
//

import SwiftUI

struct HugeBlueTitle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.largeTitle)
            .padding()
    }    
}

extension View {
    func hugeBlueTitle() -> some View {
        self.modifier(HugeBlueTitle())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Huge blue title")
            .hugeBlueTitle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
