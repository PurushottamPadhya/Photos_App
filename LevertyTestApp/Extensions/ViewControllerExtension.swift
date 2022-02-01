//
//  ViewControllerExtension.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 31/1/22.
//

import UIKit

extension UIViewController{
    func showAlertView(title: String?, msg: String?, completion: @escaping()->() = {}){
        let alertView = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: {alert in
            completion()
        }))
        self.present(alertView, animated: true)
    }
}
