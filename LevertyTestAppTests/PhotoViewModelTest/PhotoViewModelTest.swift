//
//  PhotoViewModelTest.swift
//  LevertyTestAppTests
//
//  Created by Purushottam Padhya on 1/2/22.
//

import XCTest
@testable import LevertyTestApp

class getPhotoNetworkManagerServiceSuccuess: PhotoManagerProtocol {
    // this is sample photo model class
    let photoModel = PhotoModel(albumID: 1, id: 2, title: "This is title", url: "https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg", thumbnailURL: "https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg")
    func getPhotoService(photoRequest: NetworkManager, completion: @escaping ([PhotoModel]?, Error?)-> Void){
        completion( [photoModel, photoModel], nil)
    }
}

class getPhotoNetworkManagerServiceFailed: PhotoManagerProtocol{
    func getPhotoService(photoRequest: NetworkManager, completion: @escaping ([PhotoModel]?, Error?)-> Void){
        completion(nil, NSError(domain: "Error", code: 300, userInfo: nil))
    }
}



class PhotoViewModelTest: XCTestCase {

    
    
    var photoVMTest: PhotoViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        photoVMTest = PhotoViewModel(photoManagerService: getPhotoNetworkManagerServiceSuccuess())
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        photoVMTest = nil
    }

    //MARK: - Positive test case
    func test_getPhotoWithSuccess(){
        photoVMTest = PhotoViewModel(photoManagerService: getPhotoNetworkManagerServiceSuccuess())
        photoVMTest.getAllPhoto()
        XCTAssertEqual(photoVMTest.photo.count, 2)
        
    }
    

    func test_getPhotoWithSuccess_DeletePhoto(){
        photoVMTest = PhotoViewModel(photoManagerService: getPhotoNetworkManagerServiceSuccuess())
        photoVMTest.getAllPhoto()
        let indexP = IndexPath(row: 1, section: 0)
        photoVMTest.deleteRowPhoto(at: indexP)
        XCTAssertEqual(photoVMTest.photo.count, 1)
        
    }

    func test_getPhotoWithSuccess_SearchPhotoWithTitle(){
        photoVMTest = PhotoViewModel(photoManagerService: getPhotoNetworkManagerServiceSuccuess())
        photoVMTest.getAllPhoto()
        photoVMTest.getSearchPhoto(searchText: "This")
        XCTAssertEqual(photoVMTest.photo.count, 2)
        
    }
    
    //MARK: - Negative test case
    func test_getPhotoWithFailure(){
        photoVMTest = PhotoViewModel(photoManagerService: getPhotoNetworkManagerServiceFailed())
        photoVMTest.getAllPhoto()
        XCTAssertEqual(photoVMTest.photo.count, 0)
    }
    

    func test_getPhotoWithSuccess_SearchPhotoWithTitle_NotFound(){
        photoVMTest = PhotoViewModel(photoManagerService: getPhotoNetworkManagerServiceSuccuess())
        photoVMTest.getAllPhoto()
        photoVMTest.getSearchPhoto(searchText: "notfound")
        XCTAssertEqual(photoVMTest.photo.count, 0)
        
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
