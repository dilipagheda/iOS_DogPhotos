//
//  Constants.swift
//  DogPhotos
//
//  Created by Dilip Agheda on 11/2/22.
//

enum Constants
{
    case randomImage
    case breeds
    case randomImageByBreed(String)
    
    var getString: String {
        
        get {
            switch(self) {
            case .randomImage:
                return "https://dog.ceo/api/breeds/image/random"
            case .breeds:
                return "https://dog.ceo/api/breeds/list/all"
            case .randomImageByBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            }
        }
    }
}
