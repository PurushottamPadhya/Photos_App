//
//  PhotoModel.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 26/1/22.
//

import Foundation

class PhotoModel: Codable{
    let albumID, id: Int?
    let title: String?
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }

    required init(albumID: Int?, id: Int?, title: String?, url: String?, thumbnailURL: String?) {
        self.albumID = albumID
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailURL = thumbnailURL
    }
}
