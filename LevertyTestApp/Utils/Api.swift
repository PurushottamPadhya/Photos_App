//
//  Constants.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 31/1/22.
//

import Foundation

struct Api{
    private static var baseApi: String{
        return "https://jsonplaceholder.typicode.com"
    }
    
    static var photoApi: URL{
        return URL(string: "\(baseApi)/photos")!
    }
}
