//
//  LoginViewModel.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 26/1/22.
//

import Foundation

class LoginViewModel{
    
    var loginModel = LoginModel()
    func isEmailValid( email: String)-> Bool{
        if email.isValidEmail{
            return true
        }
        return false
    }
    
    func isPasswordValid(password: String)-> Bool{
        
        if password.count >= 8{
            return true
        }
        return false
    }
    
    func isEmailPasswordValid()->(Bool, String?){
        guard let email = loginModel.email, let password = loginModel.password else{
            return (false, "Please provide email and password")
        }
        guard isEmailValid(email: email)else {
            return (false, "Please provide valid email")
            
        }
        guard isPasswordValid(password: password) else{
            return (false, "Please provide valid password length of 8 characters")
        }
        
        return (true, nil)
    }
    
    func userLoggedIn(completion: ()-> Void){
        // call login api if and return on completion handler
        
        completion()
        
    }
}
