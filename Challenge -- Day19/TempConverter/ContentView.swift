//
//  ContentView.swift
//  TempConverter
//
//  Created by André Bergvall on 2021-01-14.
//

import SwiftUI

struct ContentView: View {
    @State private var fromTemp = 0
    @State private var toTemp = 0
    @State private var inputValue = ""
    @State private var outputTemp: Double = 0
    
    let tempUnits = ["Celcius", "Fahrenheit", "Kelvin"]
    let tempAbbrevations = ["C", "F", "K"]
    
        
    var convertAnyToC: Double {
        let inputTemp = Double(inputValue) ?? 0
        switch fromTemp {
            case 0: return inputTemp
            case 1: return (inputTemp-32) / 1.8
            case 2: return inputTemp - 273.15
            default: print("invalid")
        }
        return 0
    }
    
    var createOutput: Double {
        switch toTemp {
        case 0: return convertAnyToC
        case 1: return (convertAnyToC*1.8) + 32
        case 2: return convertAnyToC + 273.15
        default: print("invalid")
        }
        return 0
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("from")){
                    Picker("From unit", selection: $fromTemp) {
                        ForEach(0 ..< tempUnits.count){
                            Text("\(self.tempUnits[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("to")){
                    Picker("From unit", selection: $toTemp) {
                        ForEach(0 ..< tempUnits.count){
                            Text("\(self.tempUnits[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section{
                    TextField("Input temperature here", text: $inputValue)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Becomes")){
                    Text("\(createOutput, specifier: "%.2f") \(self.tempAbbrevations[toTemp])")
                }
            }
            .navigationBarTitle("Temp Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
