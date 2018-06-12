//
//  ViewController.swift
//  FoodVision
//
//  Created by Niranjan Senthilkumar on 6/6/18.
//  Copyright © 2018 NJ. All rights reserved.
//

import UIKit
import CoreML
import Vision
import AVFoundation

class ScanController: UIViewController, FrameExtractorDelegate {
    
    var frameExtractor: FrameExtractor!
    
    //@IBOutlet weak var previewImage: UIImageView!
    //@IBOutlet weak var iSee: UILabel!
    
    //var flashMode = AVCaptureDevice.FlashMode.off
    //let captureSession = AVCaptureSession()
    private let session = AVCaptureSession()
    
    let previewImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        return image
    }()
    
    let iSee: UILabel = {
        let label = UILabel()
        label.text = "Detecting:"
        label.font = UIFont(name: "Avenir-Medium", size: 12)
        label.textColor = .white
        return label
    }()
    
    let cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "camera").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleScan), for: .touchUpInside)
        return button
    }()
    
    @objc func handleScan(){
        let nutritionVC = NutritionController(collectionViewLayout: UICollectionViewFlowLayout())
        
        nutritionVC.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "FoodVision"))
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 234, green: 82, blue: 111)
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        guard let scanT = self.iSee.text?.substring(from: 11) else {return}
        
        nutritionVC.scannedText = scanT
        
        let trimmedString = scanT.replacingOccurrences(of: " ", with: "")
        
        textScan = trimmedString
        
        
        navigationController?.pushViewController(nutritionVC, animated: true)
        
        
    }
    
    @objc func handleInfo(){
        let infoVC = InfoController()
        
        self.present(infoVC, animated: true, completion: nil)
    }
    
    let detectLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        return label
    }()
    
    var settingImage = false
    
    var currentImage: CIImage? {
        didSet {
            if let image = currentImage{
                self.detectScene(image: image)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frameExtractor = FrameExtractor()
        frameExtractor.delegate = self
        
        view.addSubview(previewImage)
        previewImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        
        view.addSubview(cameraButton)
        cameraButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 589, paddingLeft: 0, paddingBottom: 25, paddingRight: 0, width: 90, height: 90)
        cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(detectLabel)
        detectLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 616, paddingRight: 0, width: 0, height: 40)
        
        detectLabel.addSubview(iSee)
        iSee.anchor(top: detectLabel.topAnchor, left: nil, bottom: detectLabel.bottomAnchor, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        iSee.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "info2xwhite").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleInfo))

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "flash").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(toggleFlash))
        }
    
    @objc func toggleFlash() {
        var device : AVCaptureDevice!
        
        if #available(iOS 10.0, *) {
            let videoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInDuoCamera], mediaType: AVMediaType.video, position: .unspecified)
            let devices = videoDeviceDiscoverySession.devices
            device = devices.first!
            
        } else {
            // Fallback on earlier versions
            device = AVCaptureDevice.default(for: AVMediaType.video)
        }
        
        if ((device as AnyObject).hasMediaType(AVMediaType.video))
        {
            if (device.hasTorch)
            {
                self.session.beginConfiguration()
                //self.objOverlayView.disableCenterCameraBtn();
                if device.isTorchActive == false {
                    self.flashOn(device: device)
                } else {
                    self.flashOff(device: device);
                }
                //self.objOverlayView.enableCenterCameraBtn();
                self.session.commitConfiguration()
            }
            
        }
        
    }
    
    
    func flashOn(device:AVCaptureDevice)
    {
        do{
            if (device.hasTorch)
            {
                try device.lockForConfiguration()
                device.torchMode = .on
                device.flashMode = .on
                device.unlockForConfiguration()
            }
        }catch{
            //DISABEL FLASH BUTTON HERE IF ERROR
            print("Device tourch Flash Error ");
        }
    }
    
    func flashOff(device:AVCaptureDevice)
    {
        do{
            if (device.hasTorch){
                try device.lockForConfiguration()
                device.torchMode = .off
                device.flashMode = .off
                device.unlockForConfiguration()
            }
        }catch{
            //DISABEL FLASH BUTTON HERE IF ERROR
            print("Device tourch Flash Error ");
        }
    }
    
    func captured(image: UIImage) {
        self.previewImage.image = image
        if let cgImage = image.cgImage, !settingImage {
            settingImage = true
            DispatchQueue.global(qos: .userInteractive).async {[unowned self] in
                self.currentImage = CIImage(cgImage: cgImage)
            }
        }
    }
    
    func addEmoji(id: String) -> String {
        return ""
    }
    func detectScene(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: food().model) else {
            fatalError()
        }
        // Create a Vision request with completion handler
        let request = VNCoreMLRequest(model: model) { [unowned self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let _ = results.first else {
                    self.settingImage = false
                    return
            }
            
            DispatchQueue.main.async { [unowned self] in
                if let first = results.first {
                    if Int(first.confidence * 100) > 1 {
                        self.iSee.text = "Detecting: \(first.identifier) \(self.addEmoji(id: first.identifier))"
                        self.settingImage = false
                    }
                }
                //        results.forEach({ (result) in
                //          if Int(result.confidence * 100) > 1 {
                //            self.settingImage = false
                //            print("\(Int(result.confidence * 100))% it's \(result.identifier) ")
                //          }
                //        })
                // print("********************************")
                
            }
        }
        let handler = VNImageRequestHandler(ciImage: image)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
    }
}






