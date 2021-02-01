//
//  ContentView.swift
//  WeSplit
//
//  Created by André Bergvall on 2021-01-11.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numOfPeople = ""
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 4
    
    var useRedText: Bool {
        if tipPercentage == 4 {
            return true
        } else {
            return false
        }
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        //calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        
        let tipValue = tipSelection / 100 * orderAmount
        print(tipValue)
        let grandTotal = orderAmount + tipValue
        let costPerPerson = grandTotal / peopleCount
        
        return costPerPerson
    }
    
    var totalPerPerson2: Double {
        //calculate the total per person here
        let peopleCount = Double(numOfPeople) ?? 0
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        
        let tipValue = tipSelection / 100 * orderAmount
        print(tipValue)
        let grandTotal = orderAmount + tipValue
        let costPerPerson = grandTotal / peopleCount
        
        return costPerPerson
    }
    
    var totalAmount: Double {
        //calculate total sum of check + tip
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        
        let tipValue = tipSelection / 100 * orderAmount
        print(tipValue)
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Enter check amount:", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    //Change the “Number of people” picker to be a text field, making sure to use the correct keyboard type.
                    TextField("Enter number of people:", text: $numOfPeople).keyboardType(.numberPad)

                }
                Section(header: Text("How much tip do you want to leave?")){
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Amount per person")){
                    Text("$\(totalPerPerson2, specifier: "%.2f")")
                }
                Section(header: Text("Total amount")){
                    Text("$\(totalAmount, specifier: "%.2f")")
                        .foregroundColor(useRedText ? .red : .primary)
                }
            }
            .navigationBarTitle("WeSplit")
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
