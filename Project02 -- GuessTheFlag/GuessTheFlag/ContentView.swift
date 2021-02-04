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
    
    
//********************************
//Day34: Challenge 1 + 2 + 3
    @State private var animateCorrectAnswer = false
    @State private var animateWrongAnswer = false
//********************************
    
    
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

                    Button(action: {
                        
                        
//********************************
//Day34: Challenge 1 + 2 + 3
                        withAnimation(.easeInOut(duration: 1)){
                            if number == correctAnswer {
                                self.animateCorrectAnswer = true
                            } else {
                                self.animateWrongAnswer = true
                            }
                        }
//********************************
                        
                        
                        self.flagTapped(number)
                    }, label: {
                        FlagImageView(image: self.countries[number])
                    })
                    
                    
//********************************
//Day34: Challenge 1
                    .rotation3DEffect(.degrees(number == self.correctAnswer && self.animateCorrectAnswer ? 360 : 0), axis: (x:0, y:1, z:0))
                    .scaleEffect(number == self.correctAnswer && self.animateCorrectAnswer ? 1.5 : 1)
//********************************
                    
                    
//********************************
//Day34: Challenge 2
                    .opacity(number != self.correctAnswer && self.animateCorrectAnswer ? 0.25 : 1)
                    .scaleEffect(number != self.correctAnswer && self.animateCorrectAnswer ? 0.2 : 1)
//********************************
                    
                    
//********************************
//Day34: Challenge 3
                    .opacity(number != self.correctAnswer && self.animateWrongAnswer ? 0.25 : 1)
                    .scaleEffect(number != self.correctAnswer && self.animateWrongAnswer ? 0.2 : 1)
                    .scaleEffect(number == self.correctAnswer && self.animateWrongAnswer ? 1.5 : 1)
//********************************
                    
                    
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
        animateCorrectAnswer = false
        animateWrongAnswer = false
        correctAnswer = Int.random(in: 0...2)
        countries.shuffle()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
