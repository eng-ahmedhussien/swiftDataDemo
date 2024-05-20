//
//  EditView.swift
//  swiftDataDemo
//
//  Created by ahmed hussien on 20/05/2024.
//

import SwiftUI

struct EditView: View {
    @Bindable var expense: Expense
    var body: some View {
        Form{
            TextField("name", text: $expense.name)
            TextField("value", value: $expense.value, formatter: NumberFormatter())
            DatePicker("data", selection: $expense.date)
        }.navigationTitle("edit View")
    }
}

