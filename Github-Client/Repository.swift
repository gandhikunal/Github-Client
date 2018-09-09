//
//  Repositories.swift
//  Github-Client
//
//  Created by Kunal Gandhi on 07.09.18.
//  Copyright © 2018 Kunal Gandhi. All rights reserved.
//

import Foundation

class Owner: Codable {
    var login: String
    var id: Int
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case type
    }
    
    init(login: String, id:Int, type: String) {
        self.login = login
        self.id = id
        self.type = type
    }
}

class Repository: Codable {
    
    var id: Int
    var name: String
    var size: Int
    var createdDate: String
    var updatedDate: String
    var language: String?
    var owner: Owner
    var branches: [Branches]?
    var collaborators: [Collaborator]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case size
        case createdDate = "created_at"
        case updatedDate = "updated_at"
        case language
        case owner
    }
    
    init(id: Int, name: String, size: Int, createdDate: String, updatedDate: String, language: String? = nil, owner: Owner) {
        self.id = id
        self.name = name
        self.size = size
        self.createdDate = createdDate
        self.updatedDate = updatedDate
        self.language = language
        self.owner = owner
    }
    
}
