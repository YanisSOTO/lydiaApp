//
//  ObservableType.swift
//  lydiaApp
//
//  Created by Yanis Soto on 28/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import Foundation
import RxSwift

protocol OptionalType {
    associatedtype WrappedType
    var isNil: Bool { get }
    var value: WrappedType? { get }
    init(optional: WrappedType?)
}

extension Optional: OptionalType {
    var isNil: Bool {
        return self == nil
    }
    
    var value: Wrapped? {
        return self
    }
    
    init(optional: Wrapped?) {
        if let some = optional {
            self = .some(some)
        } else {
            self = .none
        }
    }
}


extension ObservableType where Element: OptionalType {
    func ignoreNil() -> RxSwift.Observable<Element.WrappedType> {
        return self.filter { !$0.isNil }.map {$0.value!}
    }
}
