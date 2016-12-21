//
//  ViewController.swift
//  Detector
//
//  Created by Gregg Mojica on 8/21/16.
//  Copyright © 2016 Gregg Mojica. All rights reserved.
//

import UIKit
import CoreImage


class ViewController: UIViewController {
    @IBOutlet weak var personPic: UIImageView!
    var i : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personPic.image = UIImage(named: "face-5")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // inside here guarantee the subviews has correct size
        detect()
    }
    
    func detect() {
        
        guard let personciImage = CIImage(image: personPic.image!) else {
            print("No image")
            return
        }
        
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: personciImage)

        // For converting the Core Image Coordinates to UIView Coordinates
        //original image size
        let ciImageSize = personciImage.extent.size
        print("CIimage size :  \(ciImageSize)")

        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -ciImageSize.height)
        
        for face in faces as! [CIFaceFeature] {
            
            print("Found bounds are \(face.bounds)")
            
            // Apply the transform to convert the coordinates
            var faceViewBounds = face.bounds.applying(transform)
            
            // Calculate the actual position and size of the rectangle in the image view
            //get size of image view
            let viewSize = personPic.bounds.size
            //let viewSize = UIScreen.main.bounds.size
            
            print("view Size : \(viewSize)")
            print("Ori face View bound : \(faceViewBounds)")
            let scale = min(viewSize.width / ciImageSize.width ,
                            viewSize.height / ciImageSize.height)
            print("scale : \(scale) x")
            let offsetX = (viewSize.width - ciImageSize.width * scale) / 2
            let offsetY = (viewSize.height - ciImageSize.height * scale) / 2
            
            print("x \(offsetX) , y \(offsetY)")
            
            faceViewBounds = faceViewBounds.applying(CGAffineTransform(scaleX: scale, y: scale))
            faceViewBounds.origin.x += offsetX
            faceViewBounds.origin.y += offsetY

            
            //print("tranformed face bound : \(faceViewBounds)")
            let faceBox = UIView(frame: faceViewBounds)
            
            
            
            faceBox.layer.borderWidth = 3
            faceBox.layer.borderColor = UIColor.red.cgColor
            faceBox.backgroundColor = UIColor.clear
            personPic.addSubview(faceBox)
            
            
            if face.hasLeftEyePosition {
                print("Left eye bounds are \(face.leftEyePosition)")
                face.
            }
            
            if face.hasRightEyePosition {
                print("Right eye bounds are \(face.rightEyePosition)")
            }
            
            print("\n\n")
        }
    }
    @IBAction func nextImgae(_ sender: AnyObject) {
        
        for sv in personPic.subviews{
            sv.removeFromSuperview()
        }
        i = (i + 1)%5 + 1
        let str = "face-\(i)"
        personPic.image = UIImage(named: str)
        detect()
    }
}
