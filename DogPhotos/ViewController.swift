//
//  ViewController.swift
//  DogPhotos
//
//  Created by Dilip Agheda on 10/2/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var getPhotoButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var breeds: [String] = []
    
    var selectedBreed: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DogsAPIService.getBreeds() {
            (breedsAPIResponse, error) in
            guard let breedsAPIResponse = breedsAPIResponse else {
                return
            }
            DispatchQueue.main.async {
                self.breeds = breedsAPIResponse.breeds
                self.pickerView.reloadAllComponents()
                self.selectedBreed = self.breeds[0]
                self.displayRandomDogImage()
            }

        }
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedBreed = self.breeds[row]
        self.selectedBreed = selectedBreed
        displayRandomDogImage()
    }
    
    @IBAction func onClickGetPhotoButton(_ sender: Any) {
        
        displayRandomDogImage()
    }

    public func displayRandomDogImage() {
        
        DogsAPIService.getRandomImage(breed: self.selectedBreed) {
            (image, error) in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
            
        }
    }

}

