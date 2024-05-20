//
//  ContentView.swift
//  swiftDataDemo
//
//  Created by ahmed hussien on 19/05/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query var expenseData: [Expense] // array contain all records
    @State var path = [Expense]()
    
    var body: some View {
        NavigationStack(path: $path){
            List{
                ForEach(expenseData, id: \.self) { result in
                    NavigationLink(value: result){
                        HStack {
                            Text("\(result.name)")
                            Spacer()
                            Text("\(result.value)")
                        }
                    }
                }
                .onDelete(perform: deleteExpense)
            }
            .navigationTitle("Expense Data")
            .navigationDestination(for: Expense.self, destination: { des in
                EditView(expense: des)
            })
            
            .toolbar{
                Button("add Expense") {
                    addExpense()
                }
            }
        }

       
    }
    func addExpense(){
        let newExpense = Expense()
        context.insert(newExpense)
        path = [newExpense]
    }
    
    func deleteExpense(indexSet: IndexSet) {
        for index in indexSet{
            let expense = expenseData[index]
            context.delete(expense)
        }
    }
}

#Preview {
    ContentView()
}
