//
//  PhotoViewModel.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 26/1/22.
//

import Foundation

class PhotoViewModel{
    
    var photo: [PhotoModel] = []
    var searchPhoto: [PhotoModel] = []
    var networkManager  = NetworkManager()
    var onFailure: ((String)-> ())?
    var onSuccess: (()->())?
    var onDelete:((IndexPath)->())!

    var photoManagerService: PhotoManagerProtocol!
    init(photoManagerService: PhotoManagerProtocol){
        self.photoManagerService = photoManagerService
    }
    
    func getAllPhoto(){
        self.photoManagerService.getPhotoService(photoRequest: networkManager) { [weak self] photos, error in
            guard let _self = self else {return}
            if let err = error{
                if let completion = self?.onFailure{
                    completion(err.localizedDescription)
                }
            }
            else if let responsePhotos = photos{
                _self.photo = responsePhotos
                if let completion = self?.onSuccess{
                    completion()
                }
            }
            
        }
        
    }
  
    
    func deleteRowPhoto(at indexPath: IndexPath){
        photo.remove(at: indexPath.row)
        onDelete(indexPath)
    }
    func getSearchPhoto(searchText: String){
        searchPhoto = photo.filter({$0.title?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()})
    }
    
}
