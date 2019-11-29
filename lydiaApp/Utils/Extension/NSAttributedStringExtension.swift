//
//  NSAttributedStringExtension.swift
//  lydiaApp
//
//  Created by Yanis Soto on 28/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import UIKit
extension NSAttributedString {
    // Different font used in the app
    class func mainTitle(with text: String) -> NSAttributedString {
        return attributedString(with: text, font: UIFont.systemFont(ofSize: 25.0, weight: .bold), foregroundColor: .black)
    }
    
    class func labelTitle(with text: String) -> NSAttributedString {
        return attributedString(with: text, font: UIFont.systemFont(ofSize: 18.0, weight: .bold), foregroundColor: .black)
    }
    
    class func labelSubtitle(with text: String) -> NSAttributedString {
        return attributedString(with: text, font: UIFont.systemFont(ofSize: 15.0, weight: .medium), foregroundColor: .black)
    }
    
    class func attributedString(with text: String, font: UIFont, foregroundColor: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text, attributes: [.font: font,
                                                                                    .foregroundColor: foregroundColor])
        return attributedString
    }
}


