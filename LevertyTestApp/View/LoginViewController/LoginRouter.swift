//
//  Router.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 31/1/22.
//

import UIKit

enum LoginRoute: String{
    case photo
    case other
}


class LoginRouter: Router {

    func route(
        to routeID: String,
        from context: UIViewController?,
        parameters:Any?
    ){
        if let contx = context, contx is LoginViewController{
            let route = LoginRoute(rawValue: routeID)
            if route == .photo {
                let storyboard = UIStoryboard.init(name: "Photo", bundle: nil)
                if let photoVC = storyboard.instantiateViewController(withIdentifier: "photoVC") as? PhotoViewController{
                    self.setRootVC(vc: photoVC)
                }

            }
            else{
                // handle other routing from login
            }
        }
    }
    
    func setRootVC(vc: UIViewController){
        
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return}

        guard let sceneDelegate = window.delegate as? SceneDelegate else {
            return
        }
        sceneDelegate.window?.rootViewController = vc

    }

}



