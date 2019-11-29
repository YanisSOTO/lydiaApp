//
//  RContact.swift
//  lydiaApp
//
//  Created by Yanis Soto on 28/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

public final class RContact: Object {

    ///Name struct
    @objc dynamic public var title: String = ""
    @objc dynamic public var first: String = ""
    @objc dynamic public var last: String = ""
    
    ///Picture struct
    @objc dynamic public var large: String = ""
    @objc dynamic public var thumbnail: String = ""
    @objc dynamic public var medium: String = ""
    
    @objc dynamic public var gender: String = ""
    @objc dynamic public var email: String = ""
    @objc dynamic public var birthday: String = ""
    @objc dynamic public var phone: String = ""

    class func completeFields(_ aContact: RContact, with contact: Contact) {
        aContact.title = contact.name.title
        aContact.first = contact.name.first
        aContact.last = contact.name.last
        aContact.large = contact.picture.large
        aContact.thumbnail = contact.picture.thumbnail
        aContact.medium = contact.picture.medium
        aContact.gender = contact.gender
        aContact.email = contact.email
        aContact.birthday = contact.birthday
        aContact.phone = contact.phone
    }

    class func cache(contactList: [Contact], realm: Realm)  {
        realm.beginWrite()
        
        ///Delete previous object cache
        let contactsResult = realm.objects(RContact.self)
        realm.delete(contactsResult)
        
        ///Fill new contact and add to realm
        contactList.forEach({
            let aContact = RContact()
            RContact.completeFields(aContact, with: $0)
            realm.add(aContact, update: .modified)
        })
        
        do {
            try realm.commitWrite()
        } catch {
            print("ERROR : \(type(of: self)): \(#function)")
        }
    }
    
    class func fetchContact(realm: Realm) -> Observable<[Contact]?> {
        return Observable.collection(from: realm
            .objects(RContact.self))
            .map ({ $0.map(Contact.init) })
    }

    override public static func primaryKey() -> String? {
        return "first"
    }
    
    override public static func indexedProperties() -> [String] {
        return ["title", "first", "last", "phone"]
    }
}
