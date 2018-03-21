//
//  GenQrViewController.swift
//  LetMeOutKMITL
//
//  Created by suchaj jongprasit on 3/22/2561 BE.
//  Copyright © 2561 km. All rights reserved.
//

import UIKit
class GenQrViewController: UIViewController{
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageView.image = generateQRCode(from: "asdfg")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.utf8)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
            
            filter.setValue(data, forKey: "inputMessage")
            //            https://www.youtube.com/watch?v=4Zf9dHDJ2yU
            //            https://www.youtube.com/watch?v=Lgs5J7oJtO8
            filter.setValue("H", forKey: "inputCorrectionLevel")
            colorFilter.setValue(filter.outputImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1") // Background white
            colorFilter.setValue(CIColor(red: 1, green: 0, blue: 0), forKey: "inputColor0") // Foreground or the barcode RED
            guard let qrCodeImage = colorFilter.outputImage
                else {
                    return nil
            }
            let scaleX = CGFloat(3)
            let scaleY = CGFloat(3)
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            
            
            if let output = colorFilter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}

