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
    @Query var users: [User]
    var body: some View {
        NavigationStack{
            List{
                ForEach(expenseData, id: \.self) { result in
                    HStack {
                        Text("\(result.name)")
                        Spacer()
                        Text("\(result.value)")
                    }
                }
                .onDelete(perform: deleteExpense)
                Section{
                    ForEach(users, id: \.self) { result in
                        HStack {
                            Text("\(result.name)")
                            Spacer()
                            Text("\(result.value)")
                        }
                    }
                }
            } 
            .navigationTitle("Expense Data")
            .toolbar{
                    Button("add Expense") {
                        addExpense()
                    }
                    
                    Button("add User") {
                        addUser()
                    }
                }
        }

       
    }
    func addExpense(){
        let expense = Expense(
            name: "name4",
            date: .now,
            value: 27
        )
        context.insert(expense)
    }
    func addUser(){
        let user = User(
            name: "user1",
            value: 27
        )
        context.insert(user)
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
