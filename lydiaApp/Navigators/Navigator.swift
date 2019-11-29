//
//  Navigator.swift
//  lydiaApp
//
//  Created by Yanis Soto on 27/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import Foundation

protocol Navigator {
    associatedtype Destination

    func navigate(to destination: Destination)
}
