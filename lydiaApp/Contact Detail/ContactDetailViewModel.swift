//
//  ContactDetailViewModel.swift
//  lydiaApp
//
//  Created by Yanis Soto on 28/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import Foundation


protocol  ContactDetailViewModelProtocol {
    var imageContact: URL? { get }
    var firstName: String { get }
    var lastName: String { get }
    var email: String { get }
    var phone: String { get }
    var birthDay: String { get }    
}

final class ContactDetailViewModel: ContactDetailViewModelProtocol {
    
    private let contact: Contact
    
    init(contact: Contact){
        self.contact = contact
    }
    
    var imageContact: URL? {
        URL(string: self.contact.picture.large)
    }
    
    var firstName: String {
        self.contact.firstName
    }
    
    var lastName: String {
        self.contact.lastName
    }
    
    var email: String {
        self.contact.email
    }
    
    var phone: String {
        self.contact.phone
    }
    
    var birthDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: self.contact.birthday) else {
            return "Unknow"
        }
        return date.formatString()
    }
}
