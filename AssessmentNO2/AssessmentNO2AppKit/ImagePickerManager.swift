//
//  ImagePickerManager.swift
//  AssessmentNO2
//
//  Created by Muhammad  Farhan Akram on 22/10/2024.
//


import Foundation
import UIKit
import PhotosUI // Import PhotosUI for PHPickerViewController

class ImagePickerManager: NSObject, PHPickerViewControllerDelegate {
    weak var viewController: UIViewController?
    var pickImagesCallback: (([UIImage]) -> ())?

    func pickImages(_ viewController: UIViewController, _ callback: @escaping ([UIImage]) -> ()) {
        self.viewController = viewController
        self.pickImagesCallback = callback
        
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0 // Set to 0 for unlimited selection
        configuration.filter = .images // Only show images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self // Set the delegate
        
        // Present the picker
        viewController.present(picker, animated: true, completion: nil)
    }

    // PHPickerViewControllerDelegate method
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil) // Dismiss the picker
        
        var selectedImages: [UIImage] = []
        let dispatchGroup = DispatchGroup()

        for result in results {
            dispatchGroup.enter() // Enter the group for each result
            
            // Check if the result has an image
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                    if let image = object as? UIImage {
                        selectedImages.append(image) // Append the selected image
                    }
                    dispatchGroup.leave() // Leave the group when done
                }
            } else {
                dispatchGroup.leave() // Leave if not an image
            }
        }

        // Once all images have been loaded, call the callback
        dispatchGroup.notify(queue: .main) {
            self.pickImagesCallback?(selectedImages)
        }
    }
}
