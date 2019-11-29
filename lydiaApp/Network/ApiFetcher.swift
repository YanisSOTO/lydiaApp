//
//  ApiFetcher.swift
//  lydiaApp
//
//  Created by Yanis Soto on 27/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import RxSwift

protocol ApiFetcherProtocol {
    func getContactList(number: Int) -> Observable<[Contact]>
}

public struct ApiFetcher: ApiFetcherProtocol {
  //Add protocol func in there service. Example getContactList in ContactService
}

