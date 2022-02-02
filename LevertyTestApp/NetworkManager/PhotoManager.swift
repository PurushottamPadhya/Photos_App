//
//  PhotoManager.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 2/2/22.
//

import Foundation

protocol PhotoManagerProtocol{
    
    func getPhotoService(photoRequest: NetworkManager, completion: @escaping ([PhotoModel]?, Error?)-> Void)
    
}
class PhotoManagerImplementation: PhotoManagerProtocol{
   
    func getPhotoService(photoRequest: NetworkManager, completion: @escaping ([PhotoModel]?, Error?)-> Void){
        
        photoRequest.ApiRequest(url: Api.photoApi, expecting: [PhotoModel].self) { result  in
            switch result{
            case .failure(let error):
                completion(nil, error)
            case .success(let photos):
                completion(photos, nil)
            }
        }
       
    }
    
}
