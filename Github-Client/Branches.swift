//
//  Branches.swift
//  Github-Client
//
//  Created by Kunal Gandhi on 07.09.18.
//  Copyright © 2018 Kunal Gandhi. All rights reserved.
//

import Foundation

class Branches: Codable {
    
    var branchName: String
    var shaKey: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case branchName = "name"
        case shaKey
        case url
    }
    
    init(branchName: String, shaKey: String, url: String) {
        self.branchName = branchName
        self.shaKey = shaKey
        self.url = url
    }
}

class Collaborator: Codable {
    
    var loginName: String
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case loginName = "login"
        case type
    }
    
    init(loginName: String, type: String) {
        self.loginName = loginName
        self.type = type
    }
}
