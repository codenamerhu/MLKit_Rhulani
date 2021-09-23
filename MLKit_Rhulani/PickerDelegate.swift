//
//  PickerDelegate.swift
//  MLKit_Rhulani
//
//  Created by Rhulani Ndhlovu on 2021/09/23.
//

import Foundation
import UIKit

class PickerDelegate: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {
    
    var image: UIImage?
    let imagePicker = UIImagePickerController()
    
    var delegate: PickerDelegate? {
        didSet {
            print("delegate")
            imagePicker.delegate = self
        }
    }
    
    var dataChange: (() -> Void)?
    
    override func viewDidLoad() {
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print(info[.originalImage]!)
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = pickedImage
            dataChange?()
        }
                        
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
