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
                        
//                        VStack(alignment: .leading) {
//                            Text(user.login?.capitalized ?? "")
//                                .font(.headline)
//                            Text(user.url ?? "")
//                                .font(.subheadline)
//                        }
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
                 viewModel.fetchDataByPublisher()
            }
        }
//        .task {
//            if usersFromLocalDB.isEmpty {
//                await viewModel.getUsers()
//            }
//        }
    }
}

#Preview {
    UserListView()
}


@MainActor
class VM: ObservableObject{
    @Published var users : UserModel?
    private var cancellables = Set<AnyCancellable>()
    var modelContext: ModelContext?
    init(modelContext: ModelContext?) {
        self.modelContext = modelContext
    }
    
    func fetchDataByPublisher() {
        getData()
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
    
    func getData()-> AnyPublisher<[UserModel],Error> {

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
    
}

@Model
class UserModel: Codable {
    @Attribute(.unique) var id: Int?
    let login: String?
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url: String?
    let htmlURL: String?
    let followersURL: String?
    let followingURL: String?
    let gistsURL: String?
    let starredURL: String?
    let subscriptionsURL: String?
    let organizationsURL: String?
    let reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type: String?
    let siteAdmin: Bool?
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.login = try container.decode(String.self, forKey: .login)
        self.nodeID = try container.decode(String.self, forKey: .nodeID)
        self.avatarURL = try container.decode(String.self, forKey: .avatarURL)
        self.gravatarID = try container.decode(String.self, forKey: .gravatarID)
        self.url = try container.decode(String.self, forKey: .url)
        self.htmlURL = try container.decode(String.self, forKey: .htmlURL)
        self.followersURL = try container.decode(String.self, forKey: .followersURL)
        self.followingURL = try container.decode(String.self, forKey: .followingURL)
        self.gistsURL = try container.decode(String.self, forKey: .gistsURL)
        self.starredURL = try container.decode(String.self, forKey: .starredURL)
        self.starredURL = try container.decode(String.self, forKey: .starredURL)
        self.subscriptionsURL = try container.decode(String.self, forKey: .subscriptionsURL)
        self.organizationsURL = try container.decode(String.self, forKey: .organizationsURL)
        self.reposURL = try container.decode(String.self, forKey: .reposURL)
        self.eventsURL = try container.decode(String.self, forKey: .eventsURL)
        self.receivedEventsURL = try container.decode(String.self, forKey: .receivedEventsURL)
        self.type = try container.decode(String.self, forKey: .type)
        self.siteAdmin = try container.decode(Bool.self, forKey: .siteAdmin)
    }
    
    func encode(to encoder: Encoder) throws {
        // TODO: - Handle encoding if required.
    }
}
