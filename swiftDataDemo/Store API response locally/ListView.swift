//
//  EditView.swift
//  swiftDataDemo
//
//  Created by ahmed hussien on 20/05/2024.
//

import SwiftUI
import SwiftData
import Combine

struct ListView: View {
    @EnvironmentObject var viewModel: VM
    @Query var usersFromLocalDB: [UserModel]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                List(usersFromLocalDB, id: \.id) { user in
                    HStack {
                        AsyncImage(url: URL(string: user.avatarURL ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                        } placeholder: {
                            Circle()
                                .foregroundColor(.teal)
                        }
                        .frame(width: 50, height: 50)
                        
                        VStack(alignment: .leading) {
                            Text(user.login?.capitalized ?? "")
                                .font(.headline)
                            Text(user.url ?? "")
                                .font(.subheadline)
                        }
                    }
                }
                .listStyle(.plain)
                .listRowInsets(EdgeInsets())
                .background(Color.white)
                .navigationTitle("Users")
                
            }
        }
        .onAppear{
            if usersFromLocalDB.isEmpty {
                // viewModel.getDataByPublisher()
                
                Task{
                    await viewModel.getDataByAsync()
                }
            }
        }
    }
    
    func deleteLocalData(){
        usersFromLocalDB.forEach{
            viewModel.modelContext?.delete($0)
            //  }
        }
    }
}
#Preview {
    ListView()
}
