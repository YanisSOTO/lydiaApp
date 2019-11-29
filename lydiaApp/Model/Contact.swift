//
//  Contact.swift
//  lydiaApp
//
//  Created by Yanis Soto on 27/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import Foundation

struct Results: Decodable {
    
    let contacts: [Contact]
    
    private enum CodingKeys: String, CodingKey {
      case  results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contacts = try container.decode([Contact].self, forKey: .results)
    }
}

struct Contact {
    let name: Name
    let gender: String
    let email: String
    let picture: Picture
    let phone: String
    let birthday: String
    
    public init(realmData: RContact) {
        self.name = Name(title: realmData.title, first: realmData.first, last: realmData.last)
        self.gender = realmData.gender
        self.email = realmData.email
        self.phone = realmData.phone
        self.birthday = realmData.birthday
        self.picture = Picture(large: realmData.large, thumbnail: realmData.thumbnail, medium: realmData.medium)
    }
}

extension Contact: Decodable {

    struct Name: Decodable {
        let title: String
        let first: String
        let last: String
        
        init(title: String, first: String, last: String) {
            self.title = title
            self.first = first
            self.last = last
        }
    }
    
    struct Picture: Decodable {
        let large: String
        let thumbnail: String
        let medium: String
        
        init(large: String, thumbnail: String, medium: String) {
            self.large = large
            self.thumbnail = thumbnail
            self.medium = medium
        }
    }
    
    struct Birthday: Decodable {
        let date: String
    }
    
    private enum CodingKeys: String, CodingKey {
        case name, gender, email, picture, phone, birthday = "dob", id
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name =  try container.decode(Name.self, forKey: .name)
        self.gender =  try container.decode(String.self, forKey: .gender)
        self.email =  try container.decode(String.self, forKey: .email)
        self.picture =  try container.decode(Picture.self, forKey: .picture)
        self.phone =  try container.decode(String.self, forKey: .phone)
        
        let birthday =  try container.decode(Birthday.self, forKey: .birthday)
        self.birthday = birthday.date
    }
}
