//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by André Bergvall on 2021-01-15.
//

import SwiftUI

struct FlagImageView: View {
    let image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}


struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    @State private var whichFlag = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }.foregroundColor(.white)
                
                ForEach(0..<3) { number in
                    Button(action:  { self.flagTapped(number) }) {
                        FlagImageView(image: self.countries[number])
                    }
                }
                VStack{
                    Text("Your current score is")
                    Text("\(currentScore)")
                        .font(.largeTitle)
                        .fontWeight(.black)
                }.foregroundColor(.white)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(
                title: Text(scoreTitle),
                message: Text(whichFlag),
                dismissButton: .default(Text("Continue"))
            {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer{
            scoreTitle = "Correct!"
            whichFlag = ""
            currentScore += 1
        } else {
            scoreTitle = "Wrong :("
            whichFlag = "That's the flag of \(countries[number])"
            currentScore -= 1
        }
        
        showingScore = true
    }

    func askQuestion(){
        correctAnswer = Int.random(in: 0...2)
        countries.shuffle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
