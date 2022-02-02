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
class LoginViewController: UIViewController{

    var router: LoginRouter!

    var viewModel: LoginViewModel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
//    var loginStatusBlock:(()->LoginStatus)
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.title = "Levarti APP"
        
        
        // setup keyboard event
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//        self.view.backgroundColor = .appColor
        router = LoginRouter()
        viewModel = LoginViewModel()
        viewModel.loginModel.email = emailTextField.text
        viewModel.loginModel.password = passwordTextField.text
        
        

    }
                                      
    
    func setup(){
        // these values for testing purpose
//        emailTextField.text = "a@gmail.com"
//        passwordTextField.text = "12345678"
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
    }
    //MARK: - ViewDid Disapper
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loginButton.isUserInteractionEnabled = true
    }
    
    
    //MARK : - Login button clicked handler
    @IBAction func loginButtonClicked(_ sender: Any) {
        view.endEditing(true)
        // take email and password via textfield
        // validate the email and password redirect to home or show error
        let (isFormValid, errorMessage) = viewModel.isEmailPasswordValid()
        if isFormValid{
            // once form is valid , login api is calling
            viewModel.userLoggedIn {
                loginButton.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {[weak self] in
                    guard let _self = self else{return}
                    
                    _self.router.route(to: LoginRoute.photo.rawValue, from: _self, parameters: nil)

                }
            }
        }
        else{
            self.loginButton.isUserInteractionEnabled = true
            self.showAlertView(title: "Login", msg:errorMessage ?? "Invalid Login")
        }
        
    }
    

}
//MARK:- UITextField Delegates
extension LoginViewController: UITextFieldDelegate{
    
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
            
    @objc func keyboardWillShow(notification:NSNotification){
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.loginScrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        loginScrollView.contentInset = contentInset
    }
            
    @objc func keyboardWillHide(notification:NSNotification){
                
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        loginScrollView.contentInset = contentInset
    }
    
    
}

                                               
                                               
                                        
