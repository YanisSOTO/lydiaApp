//
//  DateExtension.swift
//  lydiaApp
//
//  Created by Yanis Soto on 28/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import UIKit

//Format a date string to "MM/dd/yyyy HH:mm"
extension Date {
    func formatString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
}
