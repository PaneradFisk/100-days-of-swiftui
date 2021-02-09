//
//  AddView.swift
//  iExpense
//
//  Created by André Bergvall on 2021-02-08.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    
    @State private var showingError = false
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing:
                Button("Save", action: {
                        
//***********************
//Day 37: Challenge 3
                        saveItem()}
                )
            )
            .alert(isPresented: $showingError) {
                Alert(title: Text("Try again"),
                      message: Text("That's not a number"),
                      dismissButton: .default(Text("Okay"))
                )
            }
//***********************
            
        }
    }
    
//***********************
//Day 37: Challenge 3 : Display alert if amount is not a number.
    func saveItem() {
        if let actualAmount = Int(amount){
            let item = ExpenseItem(name: name, type: type, amount: actualAmount)
            self.expenses.items.append(item)
            self.presentationMode.wrappedValue.dismiss()
        } else {
            showingError = true
        }
    }
//***********************
    
}


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
