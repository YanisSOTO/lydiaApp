//
//  Network.swift
//  lydiaApp
//
//  Created by Yanis Soto on 27/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import Moya

protocol NetworkProtocol {
    static var endpointClose: (MultiTarget) -> Endpoint { get set }
    static var provider: MoyaProvider<MultiTarget> { get set}
}

final class MultiMoyaProvider: MoyaProvider<MultiTarget> {
    typealias Target = MultiTarget
    
    override init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure, requestClosure: @escaping MoyaProvider<Target>.RequestClosure, stubClosure: @escaping MoyaProvider<Target>.StubClosure, callbackQueue: DispatchQueue?, manager: Manager, plugins: [PluginType], trackInflights: Bool) {
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }
}


public struct Network: NetworkProtocol {
    static var endpointClose: (MultiTarget) -> Endpoint = { (target: MultiTarget) -> Endpoint in
            let defaultEndpoint = MultiMoyaProvider.defaultEndpointMapping(for: target)
        return defaultEndpoint
    }
    
    static var provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>(endpointClosure: endpointClose)
}

