//
//  Router.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 31/1/22.
//

import Foundation
import UIKit

protocol Router{
    func route(
        to routeID: String,
        from context: UIViewController?,
        parameters:Any?
    )
}
