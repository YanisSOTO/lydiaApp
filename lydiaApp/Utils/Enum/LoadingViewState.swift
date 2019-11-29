//
//  LoadingViewState.swift
//  lydiaApp
//
//  Created by Yanis Soto on 28/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

/*
 error      = request failed (network error, mapping error, authorization etc...)
 loading    = request in progress
 finished   = request succes
*/

enum LoadingViewState: Equatable {
    case error
    case loading
    case finished
}
