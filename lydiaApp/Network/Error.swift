//
//  Error.swift
//  lydiaApp
//
//  Created by Yanis Soto on 27/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import Foundation

enum ErrorNetwork: Error {
    case noNetwork
    case mappingError
    case memoryDeallocation
    case unknownError
    case failedRequest
}
