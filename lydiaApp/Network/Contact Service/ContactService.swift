//
//  ContactService.swift
//  lydiaApp
//
//  Created by Yanis Soto on 27/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import Foundation
import Moya
import RxSwift

public enum ContactRoute {
    case getContactList(results: Int)
}

public struct ContactService: GenericService {
    
    public var route: ContactRoute
    
    public init(route: ContactRoute){
        self.route = route
        self.parameters = setParameters()
    }
    
    public var path: String {
        switch self.route {
        case .getContactList:
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self.route {
        case .getContactList:
            return .get
        }
    }
    
    public var parameters: [String: Any]?
    
    func setParameters() -> [String: Any]? {
        switch self.route {
        case .getContactList(let results):
            return ["results": results]
        }
    }
}

extension ApiFetcher {

    func getContactList(number: Int = 10) -> Observable<[Contact]> {
        let obs =  Network.provider.rx
            .request(MultiTarget(ContactService(route: .getContactList(results: number))))
            .map{ response -> [Contact] in
                do {
                    let results = try JSONDecoder().decode(Results.self, from: response.data)
                    return results.contacts
                } catch {
                    throw ErrorNetwork.mappingError
                }
        }
        return obs.asObservable()
    }

}
