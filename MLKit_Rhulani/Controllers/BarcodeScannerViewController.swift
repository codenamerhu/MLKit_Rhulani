//
//  BarcodeScannerViewController.swift
//  MLKit_Rhulani
//
//  Created by Rhulani Ndhlovu on 2021/09/23.
//

import UIKit
import MobileCoreServices
import MLKit

class BarcodeScannerViewController: UIViewController {

    @IBOutlet weak var barcodeImageView: UIImageView!
    
    @IBOutlet weak var barcodeTextView: UITextView!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    let imagePicker = UIImagePickerController()
    
    let visionProcessor = VisionProcessor()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        galleryButton.striped()
        galleryButton.setCornerRadius(radius: 5)
        cameraButton.setCornerRadius(radius: 5)
        barcodeTextView.backgroundColor = .clear
        barcodeTextView.textColor = .black
    }
    
    @IBAction func chooseFromGallery(_ sender: Any) {
        openGallery()
    }
    
    @IBAction func camera(_ sender: Any) {
        openCamera()
    }
    
}

extension BarcodeScannerViewController: Gallery {
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

extension BarcodeScannerViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print(info[.originalImage]!)
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            barcodeImageView.image = pickedImage
            visionProcessor.readImageForBarcode(in: barcodeImageView, to: barcodeTextView)
        }
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
