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
    var onSuccess: (()->())?
    var onDelete:((IndexPath)->())!
    func getPhotos(){
        networkManager.ApiRequest(url: Api.photoApi, expecting: [PhotoModel].self) {[weak self] result  in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(let photos):
                self?.photo = photos
                if let completion = self?.onSuccess {
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
