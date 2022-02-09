//
//  GithubUsersViewModel.swift
//  GithubMVVM-Realm (iOS)
//
//  Created by Vince Santos on 2/9/22.
//

import Foundation
import SwiftUI

extension GithubUsersView {
    @MainActor class ViewModel: ObservableObject {
        private var apiService = APIService.shared
        
        @Published var isLoading = false
        @Published var users = [GithubUser]()
        @Published var searchText = ""
        @Published var isSearching = false
        @Published var isAlertPresented = false
        @Published var currentAlertMessage = ""
        
        func getGithubUsers() {
            isLoading = true
            apiService.getProductList(isUserInitiated: false) { [self] githubUsersResult in
                isLoading = false
                switch githubUsersResult {
                case .success(let gitUsersList):
                    users = Array(gitUsersList.list)
                case .failure(let error):
                    currentAlertMessage = error.message
                    isAlertPresented = true
                }
            }
        }
        
        func startSearching() {
            isSearching = true
        }
        
        func clearSearchText() {
            searchText = ""
        }
        
        func stopSearching() {
            isSearching = false
            searchText = ""
        }
    }
}
