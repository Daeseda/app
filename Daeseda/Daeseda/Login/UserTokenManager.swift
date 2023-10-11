//
//  UserTokenManager.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/10/10.
//

import Foundation

class UserTokenManager {
    static let shared = UserTokenManager()
    
    var authToken: String?
    
    private init() {
    }
    
    func saveToken(token: String) {
        authToken = token
    }
    
    func getToken() -> String? {
        return authToken
    }
}
