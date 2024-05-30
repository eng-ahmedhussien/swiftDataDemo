//
//  swiftDataDemoApp.swift
//  swiftDataDemo
//
//  Created by ahmed hussien on 19/05/2024.
//

import SwiftUI
import SwiftData

//@main
//struct swiftDataDemoApp: App {
//   
//    
//    let container: ModelContainer = {
//        let schema = Schema([Expense.self])
//        let container =  try! ModelContainer(for: schema, configurations: [])
//        return container
//    }()
//    
//    let controller = DBManger.shared
//    
//    var body: some Scene {
//        WindowGroup {
//           //ContentView()
//            UserListView()
//                .modelContainer(controller.container)
//        }
//       // .modelContainer(for: [Expense.self])
//        //.modelContainer(container)
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


@main
struct swiftDataDemoApp: App {

    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ListView()
                .environmentObject(VM(modelContext: container.mainContext))
                .modelContainer(container)
        }
    }
    
    init() {
        do {
            container = try ModelContainer(for: UserModel.self)
        } catch {
            fatalError("Failed to create ModelContainer for UserModel.")
        }
    }
}


