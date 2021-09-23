//
//  TextRecognitionViewController.swift
//  MLKit_Rhulani
//
//  Created by Rhulani Ndhlovu on 2021/09/23.
//

import UIKit
import MobileCoreServices
import MLKit

class TextRecognitionViewController: UIViewController {
    
    @IBOutlet weak var textImage: UIImageView!

    let textRecognizer = TextRecognizer.textRecognizer()
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var scannedTextArea: UITextView!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    let visionProcessor = VisionProcessor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scannedTextArea.isEditable = false
        
        imagePicker.delegate = self
        galleryButton.striped()
        galleryButton.setCornerRadius(radius: 5)
        cameraButton.setCornerRadius(radius: 5)
        scannedTextArea.backgroundColor = .clear
        scannedTextArea.textColor = .black
    }
    
    @IBAction func camera(_ sender: Any) {
        openCamera()
    }
    
    @IBAction func chooseFromGallery(_ sender: Any) {
        openGallery()
    }
    
}

extension TextRecognitionViewController : Gallery {
    
    func openGallery() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [String(kUTTypeImage), String(kUTTypeMovie)]
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.mediaTypes = [String(kUTTypeImage), String(kUTTypeMovie)]
        present(imagePicker, animated: true, completion: nil)
    }
}

extension TextRecognitionViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print(info[.originalImage]!)
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            textImage.image = pickedImage
            visionProcessor.detectImage(in: textImage, to: scannedTextArea)
        }
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
