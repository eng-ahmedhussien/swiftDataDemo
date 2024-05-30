//
//  UserModel.swift
//  swiftDataDemo
//
//  Created by ahmed hussien on 30/05/2024.
//

import Foundation
import SwiftData

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
