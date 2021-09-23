//
//  VisionProcessor.swift
//  MLKit_Rhulani
//
//  Created by Rhulani Ndhlovu on 2021/09/23.
//

import Foundation
import MLKit

class VisionProcessor {
    var textRecognizer: TextRecognizer
    var barcodeScanner: BarcodeScanner
    var faceDetector: FaceDetector
    
    init() {
        textRecognizer = TextRecognizer.textRecognizer()
        barcodeScanner = BarcodeScanner.barcodeScanner()
        faceDetector = FaceDetector.faceDetector()
    }
    
    func detectImage(in imageView: UIImageView, to textView: UITextView, completion: (() -> Void)? = nil) {
      
        let visionImage = VisionImage(image: imageView.image!)
        
        textRecognizer.process(visionImage, completion: { result, error in
            
            guard error == nil, let result = result else {
                return
              }
            
            textView.text = result.text
        })
    }
    
    func readImageForBarcode(in imageView: UIImageView, to textView: UITextView, completion: (() -> Void)? = nil) {
        
        let barcodeOptions = BarcodeScannerOptions(formats: .all)
        let barcodeScanner = BarcodeScanner.barcodeScanner(options: barcodeOptions)
        
        let visionImage = VisionImage(image: imageView.image!)
        
        barcodeScanner.process(visionImage) { barcodes, error in
          guard error == nil, let barcodes = barcodes, !barcodes.isEmpty else {
            return
          }
            
            for barcode in barcodes {
                let rawValue = barcode.rawValue!
                let valueType = barcode.valueType
                
                switch valueType {
                case .URL:
                    textView.text = "URL: \(rawValue)"
                case .phone:
                    textView.text = "Phone number: \(rawValue)"
                default:
                    textView.text = rawValue
                }
            }
        }
    }
    
    func detectFace(in imageView: UIImageView, to textView: UITextView, completion: (() -> Void)? = nil) {
      
        let visionImage = VisionImage(image: imageView.image!)
        
        let options = FaceDetectorOptions()
        options.performanceMode = .accurate
        options.landmarkMode = .all
        options.classificationMode = .all
        
        let faceDetector = FaceDetector.faceDetector(options: options)
        
        weak var weakSelf = self
        faceDetector.process(visionImage) { faces, error in
          guard let _ = weakSelf else {
            return
          }
          guard error == nil, let faces = faces, !faces.isEmpty else {
            
            return
          }
            
            for face in faces {
                if face.hasLeftEyeOpenProbability {
                    if face.leftEyeOpenProbability < 0.4 {
                        textView.text = textView.text + "The left eye is not open!\n"
                    } else {
                        textView.text = textView.text + "The left eye is open!\n"
                    }
                }
                
                if face.hasRightEyeOpenProbability {
                    if face.rightEyeOpenProbability < 0.4 {
                        textView.text = textView.text + "The right eye is not open!\n"
                    } else {
                        textView.text = textView.text + "The right eye is open!\n"
                    }
                }
                
                if face.hasSmilingProbability {
                    if face.smilingProbability < 0.3 {
                        textView.text = textView.text + "This person is not smiling.\n\n"
                    } else {
                        textView.text = textView.text + "This person is smiling.\n\n"
                    }
                }
            }
        }
    }
    
}
