//
//  BreedsAPIResponse.swift
//  DogPhotos
//
//  Created by Dilip Agheda on 11/2/22.
//

import Foundation

struct BreedsAPIResponse: Codable
{
    let message: [String: [String]]
    
    var breeds: [String] {
        
        get {
            return message.keys.map({$0})
        }
    }
}
