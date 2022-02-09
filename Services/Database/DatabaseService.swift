//
//  DatabaseService.swift
//  WaveEnterprise (iOS)
//
//  Created by Vince Santos on 12/27/21.
//

import Foundation
import RealmSwift

class DatabaseService: ObservableObject {
    static let shared = DatabaseService()
    
    func updateGithubUserList(users: [GithubUser], completion: @escaping (GithubUserList) -> Void) {
        let realm = try! Realm()
        
        if let hasGithubUserList = realm.objects(GithubUserList.self).first {
            try? realm.safeWrite {
                hasGithubUserList.list.removeAll()
                hasGithubUserList.list.append(objectsIn: users)
                completion(hasGithubUserList)
            }
        } else {
            let githubUserList = GithubUserList()
            githubUserList.list.append(objectsIn: users)
            
            try? realm.safeWrite {
                realm.add(githubUserList)
                completion(githubUserList)
            }
        }
    }
    
    func getGithubUserList(completion: @escaping (GithubUserList?) -> Void) {
        let realm = try! Realm()
        
        if let hasGithubUserList = realm.objects(GithubUserList.self).first {
            completion(hasGithubUserList)
        } else {
            completion(nil)
        }
    }
}
