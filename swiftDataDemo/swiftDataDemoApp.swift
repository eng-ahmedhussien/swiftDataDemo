//
//  swiftDataDemoApp.swift
//  swiftDataDemo
//
//  Created by ahmed hussien on 19/05/2024.
//

import SwiftUI

@main
struct swiftDataDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Expense.self,User.self])
    }
}
