//
//  CameraViewController.swift
//  PIC-Minder
//
//  Created by user on 7/15/17.
//  Copyright © 2017 taterbait. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
var captureSession = AVCaptureSession ()
var sessionOutput = AVCapturePhotoOutput ()
var previewLayer = AVCaptureVideoPreviewLayer ()
    
@IBOutlet weak var cameraView: UIView!
@IBOutlet weak var button: UIStackView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //I don't want this to rotate
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    // Time for PictureView overlay to run
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let deviceSession =  AVCaptureDeviceDiscoverySession(deviceTypes: [AVCaptureDeviceType.builtInDuoCamera, .builtInTelephotoCamera, .builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: .unspecified)
        for device in(deviceSession?.devices)! {
            if device.position == AVCaptureDevicePosition.back {
                do
                {
                    let input = try AVCaptureDeviceInput(device: device)
                    if captureSession.canAddInput(input){
                        captureSession.addInput(input)
                            if captureSession.canAddOutput(sessionOutput){
                                captureSession.addOutput(sessionOutput)
                        
                                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                                previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                                previewLayer.connection.videoOrientation = .portrait
                            
                                cameraView.layer.addSublayer(previewLayer)
                                cameraView.addSubview(button)
                            
                                previewLayer.position = CGPoint (x: self.cameraView.frame.width / 2, y:self.cameraView.frame.height / 2)
                                previewLayer.bounds = cameraView.frame
                            
                                captureSession.startRunning()
                            }
                     }
                }
                catch let avError
                {
                    print(avError)
                }
            }
        }
     
    }
    
    @IBAction func takePhoto(_ sender: Any) {
    let settings = AVCapturePhotoSettings ()
    let previewPixelType =  settings.availablePreviewPhotoPixelFormatTypes.first!
    let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String : previewPixelType, kCVPixelBufferWidthKey as String : 160, kCVPixelBufferHeightKey as String : 160]
    settings.previewPhotoFormat = previewFormat
    sessionOutput.capturePhoto(with: settings, delegate: self)
    }

}
