//
//  DatabaseServiceModel.swift
//  WaveEnterprise (iOS)
//
//  Created by Vince Santos on 12/27/21.
//

import Foundation
import RealmSwift

class GithubUser: Object {
    @Persisted var login: String
    @Persisted var id: Int
    @Persisted var nodeId: String
    @Persisted var avatarUrl: String
    @Persisted var gravatarId: String
    @Persisted var url: String
    @Persisted var htmlUrl: String
    @Persisted var followersUrl: String
    @Persisted var followingUrl: String
    @Persisted var gistsUrl: String
    @Persisted var starredUrl: String
    @Persisted var subscripstionsUrl: String
    @Persisted var organizationUrl: String
    @Persisted var reposUrl: String
    @Persisted var eventsUrl: String
    @Persisted var receivedEventsUrl: String
    @Persisted var type: String
    @Persisted var siteAdmin: String
}

class GithubUserList: Object {
    @Persisted var list: List<GithubUser>
}
