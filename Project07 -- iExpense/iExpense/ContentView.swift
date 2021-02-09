//
//  ContentView.swift
//  iExpense
//
//  Created by André Bergvall on 2021-02-07.
//

import SwiftUI




struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                            
                        }
                        Spacer()
                        
//***********************
//Day 37: Challenge 2 : Add styling depending on amount.
                        if item.amount <= 10 {
                            Text("$\(item.amount)").background(Color.green)
                        } else if item.amount <= 100 {
                            Text("$\(item.amount)").background(Color.yellow)
                        } else {
                            Text("$\(item.amount)").background(Color.red)
                        }
//***********************
                        
                    }
                    
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")

            
//***********************
//Day 37: Challenge 1 : Add EditButton for ease of deletion
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(
                    action: {showingAddExpense = true},
                    label: {Image(systemName: "plus")}
                )
            )
//***********************
            
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
