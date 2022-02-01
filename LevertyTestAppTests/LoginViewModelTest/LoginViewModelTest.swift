//
//  LoginViewModelTest.swift
//  LevertyTestAppTests
//
//  Created by Purushottam Padhya on 1/2/22.
//

import XCTest
@testable import LevertyTestApp

class LoginViewModelTest: XCTestCase {
    var loginTestVM: LoginViewModel!
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        loginTestVM = LoginViewModel()
    }

    override func tearDownWithError() throws {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        loginTestVM = nil
    }
    
    //MARK: - Positive Test cases
    func testEmailIsValid(){
        let email = "a@gmail.com"
        let isValid = loginTestVM.isEmailValid(email: email)
        XCTAssertTrue(isValid)
    }
    func testPasswordLengthIsValid(){
        let pass = "123456789"
        let isValid = loginTestVM.isPasswordValid(password: pass)
        XCTAssertTrue(isValid)
    }
    
    func testEmailPasswordIsValid(){
        loginTestVM.loginModel.email = "a@gmail.com"
        loginTestVM.loginModel.password = "1234567890"
        let (isValid, _) = loginTestVM.isEmailPasswordValid()
        XCTAssertTrue(isValid)
    }
    
    // MARK: - Negative Test Cases

    //MARK: - Positive Test cases
    func testEmailIsInvalid(){
        let email = "a@gmailcom"
        let isValid = loginTestVM.isEmailValid(email: email)
        XCTAssertFalse(isValid)
    }
    func testPasswordLengthIsInvalid(){
        let pass = "1234"
        let isValid = loginTestVM.isPasswordValid(password: pass)
        XCTAssertFalse(isValid)
    }
    
    func testEmailPasswordIsInvalid(){
        loginTestVM.loginModel.email = "a@gmail.co"
        loginTestVM.loginModel.password = "1234567890"
        let (isValid, _) = loginTestVM.isEmailPasswordValid()
        XCTAssertFalse(isValid)
    }
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
