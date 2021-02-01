//
//  ContentView.swift
//  rockPaperScissors
//
//  Created by André Bergvall on 2021-01-20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var turnsCount = 0
    @State private var showingScore = false
    
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var computerPick = Int.random(in: 0...2)
    let picks = ["Rock", "Paper", "Scissors"]
    let picksImages = ["👊", "🖐", "✌️"]
    
    var scoreBoard: Alert {
        Alert(title: Text("\(score) points"), message: Text("10 turns played"), dismissButton: .default(Text("Restart")) { resetGame() })
    }
    
    var randomPick: String {
        picksImages[computerPick]
    }
    
    var body: some View {
        VStack{
            Spacer()
            VStack{
                Text("My pick is ").padding()
                Text("\(randomPick)").padding()
                if shouldWin {
                    Text("You must win!").foregroundColor(.blue)
                } else {
                    Text("You must lose!").foregroundColor(.red)
                }
            }
            .font(.largeTitle)
            Spacer()

            HStack{
                ForEach(0..<picks.count) { pick in
                    Button(action: {
                        rpsLogic(pick)
                        newTurn()
                        takeTurn()
                    }, label: {
                        Text("\(self.picksImages[pick])")
                    })
                    .padding()
                    .font(.largeTitle)
                    .border(Color.blue, width: 1)
                }
            }
        }
        .alert(isPresented: $showingScore, content: { scoreBoard })
    }
    
    func rpsLogic(_ humanPick: Int){
        if(shouldWin && (computerPick == humanPick-1 || (computerPick == 2 && humanPick == 0))) {
            score += 1
        } else if (!shouldWin && (computerPick == humanPick+1 || (computerPick == 0 && humanPick == 2))) {
            score += 1
        } else {
            score -= 1
        }
    }
        
    func newTurn(){
        shouldWin = Bool.random()
        computerPick = Int.random(in: 0...2)

    }
    
    func takeTurn(){
        turnsCount += 1
        if (turnsCount == 10){
            showingScore = true
        }
    }
    
    func resetGame(){
        self.turnsCount = 0
        self.score = 0
        showingScore = false
        newTurn()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
