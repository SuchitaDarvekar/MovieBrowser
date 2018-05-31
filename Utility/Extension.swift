//
//  Extension.swift
//  MovieApp
//
//  Created by webwerks on 28/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation
import UIKit
extension UILabel{
    
func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    label.sizeToFit()
    return label.frame.height
}
}

extension UIViewController{
    func showAlert(string:String) {
        let alert  = UIAlertController(title: "", message: string, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
