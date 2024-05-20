//
//  Expense.swift
//  swiftDataDemo
//
//  Created by ahmed hussien on 19/05/2024.
//

import SwiftUI
import SwiftData

@Model
class Expense{
    // @Attribute(.unique) var name: String
        var name: String
        var date: Date
        var value: Double
        
        init(name: String, date: Date, value: Double) {
            self.name = name
            self.date = date
            self.value = value
        }
}


@Model class User {
        @Attribute(.unique) var name: String
        var value: Double
        
        init(name: String, value: Double) {
            self.name = name
            self.value = value
        }
}
