//
//  ContactCellData.swift
//  lydiaApp
//
//  Created by Yanis Soto on 28/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import Foundation

protocol ContactCellData {
    var firstName: String { get }
    var lastName: String { get }
    var image: URL? { get }
    var phoneNumber: String { get }
}

extension Contact: ContactCellData {
    var firstName: String {
        self.name.first
    }
    
    var lastName: String {
        self.name.last
    }
    
    var image: URL? {
        URL(string: self.picture.thumbnail)
    }
    
    var phoneNumber: String {
        self.phone
    }
}
