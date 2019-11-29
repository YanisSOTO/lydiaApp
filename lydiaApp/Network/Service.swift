//
//  Service.swift
//  lydiaApp
//
//  Created by Yanis Soto on 27/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import Moya

public protocol GenericService: TargetType {
    var parameters: [String: Any]? {get set}
}

extension GenericService {
    
    ///The headers property stores header fields that should be sent on the request.
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var baseURL: URL { return URL(string: "https://randomuser.me/api/")! }
    
    public var sampleData: Data {
        return "[]".UTF8EncodedData
    }
    
    public var task: Task {
        if let params = self.parameters {
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        } else {
            return .requestPlain
        }
    }
}

// MARK: - Helpers
private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
    var UTF8EncodedData: Data {
        return self.data(using: String.Encoding.utf8)!
    }
}
