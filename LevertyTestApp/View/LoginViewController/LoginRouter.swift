//
//  Router.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 31/1/22.
//

import UIKit

enum LoginRoute: String{
    case photo
}


class LoginRouter: Router {

    func route(
        to routeID: String,
        from context: UIViewController?,
        parameters:Any?
    ){
        if let contx = context{
            let storyboard = UIStoryboard.init(name: "Photo", bundle: nil)
            if let photoVC = storyboard.instantiateViewController(withIdentifier: "photoVC") as? PhotoViewController{
                contx.showDetailViewController(photoVC, sender: nil)
            }
        }
        
        
    }

}




