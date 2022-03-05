//
//  DogsAPIService.swift
//  DogPhotos
//
//  Created by Dilip Agheda on 11/2/22.
//

import Foundation
import UIKit

class DogsAPIService
{
    
    public static func getBreeds(completionHandler: @escaping (BreedsAPIResponse?, Error?) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: URL(string: Constants.breeds.getString)!) {
            (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let breedsAPIResponse = try! JSONDecoder().decode(BreedsAPIResponse.self, from: data)
            completionHandler(breedsAPIResponse, nil)
            
        }
        dataTask.resume()
    }
    
    private static func getRandomImageURL(completionHandler: @escaping (URL?, Error?) -> Void) {
        let randomURL = URL(string: Constants.randomImage.getString)!
        
        let dataTask = URLSession.shared.dataTask(with: randomURL) {
            (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            do {
                let randomAPIResponse = try JSONDecoder().decode(RandomAPIResponse.self, from: data)
                completionHandler(URL(string: randomAPIResponse.message)!, nil)
            }catch{
                completionHandler(nil, error)
            }
        }
        dataTask.resume()
    }
    
    private static func getRandomImageByBreedURL(breed: String, completionHandler: @escaping (URL?, Error?) -> Void) {
        let randomByBreedURL = URL(string: Constants.randomImageByBreed(breed).getString)!
        
        let dataTask = URLSession.shared.dataTask(with: randomByBreedURL) {
            (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            do {
                let randomAPIResponse = try JSONDecoder().decode(RandomAPIResponse.self, from: data)
                completionHandler(URL(string: randomAPIResponse.message)!, nil)
            }catch{
                completionHandler(nil, error)
            }
        }
        dataTask.resume()
    }
    
    public static func getRandomImage(breed: String?, completionHandler: @escaping (UIImage?, Error?) -> Void){
        
        func handler(url: URL?, error: Error?){
            guard let url = url else{
                completionHandler(nil, error)
                return
            }
            let dataTask = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                guard let data = data else {
                    completionHandler(nil, error)
                    return
                }
                completionHandler(UIImage(data: data), nil)
            }
            dataTask.resume()
        }
        
        guard let breed = breed else {
            self.getRandomImageURL(completionHandler: handler)
            return
        }

        self.getRandomImageByBreedURL(breed: breed, completionHandler: handler)
    }
}
