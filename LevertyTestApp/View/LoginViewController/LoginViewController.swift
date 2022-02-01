//
//  LoginViewController.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 26/1/22.
//

import UIKit

//protocol LoginRouter{
//    func perform(_ seque: Route, from source: UIViewController)
//}
enum LoginStatus: String{
    case succed
    case failed
}
class LoginViewController: UIViewController, UITextFieldDelegate{

    var router: LoginRouter!

    var viewModel: LoginViewModel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    @IBOutlet weak var emailTextField: UITextField!
//    var loginStatusBlock:(()->LoginStatus)
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel = LoginViewModel()
        viewModel.loginModel.email = emailTextField.text
        viewModel.loginModel.password = passwordTextField.text
        

    }
    
    func setup(){
//        emailTextField.text = "a@gmail.com"
//        passwordTextField.text = "12345678"
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        // take email and password via textfield
        // validate the email and password redirect to home or show error
        let (isFormValid, errorMessage) = viewModel.isEmailPasswordValid()
        if isFormValid{
            // once form is valid , login api is calling
            viewModel.userLoggedIn {
//                    self.router.navigate(to: .photo)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {[weak self] in
                    guard let _self = self else{return}
                   
                    let storyboard = UIStoryboard.init(name: "Photo", bundle: nil)
                    if let photoVC = storyboard.instantiateViewController(withIdentifier: "photoVC") as? PhotoViewController{
                        _self.navigationController?.pushViewController(photoVC, animated: true)
                    }
                }
            }
        }
        else{
            self.showAlertView(title: "Login", msg:errorMessage ?? "Invalid Login")
        }
        
    }
}
//MARK:- UITextField Delegates
extension LoginViewController: UITextViewDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField{
            viewModel.loginModel.email = textField.text
        }
        else if textField == passwordTextField{
            viewModel.loginModel.password = textField.text
        }
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField{
            passwordTextField.becomeFirstResponder()
        }
        else{
            self.view.endEditing(true)
        }
        return false
    }
    
    
}
