//
//  Button.swift
//  MLKit_Rhulani
//
//  Created by Rhulani Ndhlovu on 2021/09/23.
//

import Foundation
import UIKit

extension UIButton {
    
    func setCornerRadius(radius: Int) {
        self.layer.cornerRadius = CGFloat(radius)
    }
    
    func striped(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.green.cgColor
        self.backgroundColor = UIColor.white
    }
}
