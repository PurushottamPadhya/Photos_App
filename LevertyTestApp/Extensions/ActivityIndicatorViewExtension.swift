//
//  ActivityIndicatorViewExtension.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 1/2/22.
//

import Foundation
import UIKit

extension UIView{
    func showLoader(){
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.backgroundColor = .appColor
        indicator.layer.cornerRadius = 5.0
        indicator.clipsToBounds = true
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = self.center
        indicator.startAnimating()
        indicator.tag = 123456
        self.isUserInteractionEnabled = false
        self.addSubview(indicator)
    }
    
    func dismissLoader(){
        if let indicator = viewWithTag(123456){
            indicator.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}
