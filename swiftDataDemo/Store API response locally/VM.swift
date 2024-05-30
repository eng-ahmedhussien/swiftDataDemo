//
//  VM.swift
//  swiftDataDemo
//
//  Created by ahmed hussien on 30/05/2024.
//

import Foundation
import Combine
import SwiftData

@MainActor
class VM: ObservableObject{
    @Published var users : UserModel?
    private var cancellables = Set<AnyCancellable>()
    var modelContext: ModelContext?
    
    init(modelContext: ModelContext?) {
        self.modelContext = modelContext
    }
    
    func getDataByPublisher() {
        fetchDataByPublisher()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Data retrieval finished")
                case .failure(let error):
                    print("Data retrieval failed with error: \(error.localizedDescription)")
                }
            } receiveValue: { data in
              //  self.users = data
                let userss = data
                userss.forEach { self.modelContext?.insert($0) }
            }
            .store(in: &cancellables)
    }
    func fetchDataByPublisher()-> AnyPublisher<[UserModel],Error> {

        guard let url = URL(string: "https://api.github.com/users") else {
            return Fail(error: Error.self as! Error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                return output.data
            }
            .decode(type: [UserModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    //MARK: using async
    func fetchDataByAsync()async throws -> [UserModel]?{
        guard let url = URL(string: "https://api.github.com/users") else {
            throw URLError(.badURL)
        }
        
        let (data, _) =  try await URLSession.shared.data(from: url)
        let json = try JSONDecoder().decode([UserModel].self, from: data)
        return json
    }
    func getDataByAsync() async{
        let users = try? await fetchDataByAsync()
        users?.forEach{ self.modelContext?.insert($0)}
    }
    
}
