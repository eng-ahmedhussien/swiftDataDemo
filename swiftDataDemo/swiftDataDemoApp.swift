//
//  swiftDataDemoApp.swift
//  swiftDataDemo
//
//  Created by ahmed hussien on 19/05/2024.
//

import SwiftUI
import SwiftData

@main
struct swiftDataDemoApp: App {
   
    //1
    var container: ModelContainer = {
        let schema = Schema([Expense.self])
        let container =  try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    let controller = DBManger.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
             .modelContainer(container) //3
            // .modelContainer(for: [Expense.self])
            
           /* UserListView()
                .modelContainer(controller.container)*/
        }
       
    }
    
    //2
    init() {
        do {
            container = try ModelContainer(for: Expense.self)
        } catch {
            fatalError("Failed to create ModelContainer for UserModel.")
        }
    }
}


//@main
//struct swiftDataDemoApp: App {
//
//    let container: ModelContainer
//    
//    var body: some Scene {
//        WindowGroup {
//            ListView()
//                .environmentObject(VM(modelContext: container.mainContext))
//                .modelContainer(container)
//        }
//    }
//    
//    init() {
//        do {
//            container = try ModelContainer(for: UserModel.self)
//        } catch {
//            fatalError("Failed to create ModelContainer for UserModel.")
//        }
//    }
//}
//
//
