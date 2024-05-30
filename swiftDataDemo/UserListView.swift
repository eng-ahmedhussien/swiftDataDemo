//
//  userEx.swift
//  swiftDataDemo
//
//  Created by ahmed hussien on 22/05/2024.
//

import SwiftUI
import SwiftData

struct UserListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \User.name, order: .forward) private var users: [User]

    @State private var showAddUserSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text("Age: \(user.age)")
                            .font(.subheadline)
                    }
                }
                .onDelete(perform: deleteUser)
            }
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddUserSheet.toggle() }) {
                        Label("Add User", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddUserSheet) {
                AddUserView()
            }
        }
    }

    private func deleteUser(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(users[index])
        }
    }
}

struct AddUserView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var age: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Age", text: $age)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Add User")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let user = User(name: name, age: Int(age) ?? 0)
                        DBManger.shared.addUser(user: user)
                        dismiss()
                    }
                }
            }
        }
    }
}

class DBManger {
    static let shared = DBManger()
    let container: ModelContainer
    private init() {
        do {
            container = try ModelContainer(for: User.self)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    @MainActor
    func addUser(user:User){
        container.mainContext.insert(user)
    }
}

@Model
class User {
    var id: UUID
    var name: String
    var age: Int

    init(id: UUID = UUID(), name: String, age: Int) {
        self.id = id
        self.name = name
        self.age = age
    }
}
