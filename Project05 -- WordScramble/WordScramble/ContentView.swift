//
//  ContentView.swift
//  WordScramble
//
//  Created by André Bergvall on 2021-01-24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMsg = ""
    @State private var showingError = false
    
    //***********************************
    //challenge 3: calculation
    var score: Int {
        var points = 0
        for word in usedWords {
            points += word.count
        }
        return points
    }
    //***********************************

    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Enter your word", text: $newWord, onCommit: addNewWorld)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                //***********************************
                //challenge 3: implementation of UI
                Spacer()
                Text("Current score: \(score)")
                //***********************************

            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: {startGame()})
            .alert(isPresented: $showingError, content: {
                Alert(title: Text(errorTitle), message: Text(errorMsg), dismissButton: .default(Text("ok")))
            })
            //***********************************
            //challenge 2: adding restart button to navbar
            .navigationBarItems(leading: Button("Restart", action: startGame))
            //***********************************
        }
    }
    
    func addNewWorld(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {
            return
        }
        guard isOriginal(word: answer) else {
            wordError(title: "\(answer) used already", msg: "Be more original.")
            newWord = ""
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "\(answer) is not possible", msg: "Missing required letters.")
            newWord = ""
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "\(answer) is not allowed", msg: "Make it 4 letters, a real word and not the same as the starting one.")
            newWord = ""
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame(){
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        //***********************************
        //challenge 1: excluding rootWord and words of 3 or fewer letters
        if word.count < 3 || word == rootWord {
            return false
        }
        //***********************************

        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, msg: String) {
        errorTitle = title
        errorMsg = msg
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
