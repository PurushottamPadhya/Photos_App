//
//  UIRefreshControlExtension.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 1/2/22.
//

import UIKit
extension UIRefreshControl{
    
    func addRefreshControl(tableView: UITableView, message: String){
        self.attributedTitle = NSAttributedString(string: message)
        self.backgroundColor = .white
        tableView.addSubview(self)
    }
}
