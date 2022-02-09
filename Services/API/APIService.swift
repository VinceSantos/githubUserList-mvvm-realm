//
//  APIService.swift
//  GithubMVVM-Realm (iOS)
//
//  Created by Vince Santos on 02/09/22.
//

import Foundation
import SwiftyJSON
import SwiftUI

final class APIService: ObservableObject {
    static let shared = APIService()
    
    func getProductList(isUserInitiated: Bool, completion: @escaping (Result<GithubUserList, StringError>) -> Void){
        guard let url = URL(string: Constants.githubUsersUrl) else { return }
        
        DispatchQueue.global(qos: isUserInitiated ? .userInitiated : .background).async {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let hasData = data {
                        if let dataJson = try? JSON(data: hasData) {
                            if let jsonArray = dataJson.array {
                                var githubUserList = [GithubUser]()
                                
                                for user in jsonArray {
                                    let githubUser = GithubUser()
                                    githubUser.login = user["login"].stringValue
                                    githubUser.id = user["id"].intValue
                                    githubUser.type = user["type"].stringValue
                                    githubUser.avatarUrl = user["avatar_url"].stringValue
                                    
                                    githubUserList.append(githubUser)
                                }
                                
                                DatabaseService.shared.updateGithubUserList(users: githubUserList) { localGithubUsers in
                                    completion(.success(localGithubUsers))
                                }
                            }
                        } else {
                            if let hasError = error {
                                completion(.failure(.init(message: hasError.localizedDescription)))
                            }
                        }
                    } else {
                        completion(.failure(.init(message: ErrorMessages.serverErrorMessage)))
                    }
                }
            }.resume()
        }
    }
}
