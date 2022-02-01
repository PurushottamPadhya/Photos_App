//
//  Color.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 1/2/22.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1) {
        self.init(hexa: UInt(hex.dropFirst(), radix: 16) ?? 0, alpha: alpha)
    }
    convenience init(hexa: UInt, alpha: CGFloat = 1) {
        self.init(red:   .init((hexa & 0xff0000) >> 16) / 255,
                  green: .init((hexa & 0xff00  ) >>  8) / 255,
                  blue:  .init( hexa & 0xff    )        / 255,
                  alpha: alpha)
    }
}
extension UIColor{
    
    static var appColor : UIColor {
        return UIColor(hex: "#48c3ff")
    }
    static var textTitleColor: UIColor{
        return .darkText
    }
    static var secondaryColor: UIColor{
        return .white
    }
    
    static var textSubtitleColor: UIColor{
        return .lightText
    }
    
    static var cellBackGroundColor: UIColor{
        return .lightGray
    }
    
}

