//
//  ScanViewControlloerViewController.swift
//  ios-group
//
//  Created by Christopher on 24/05/2018.
//  Copyright © 2018 Minny Lin. All rights reserved.
//

import UIKit
import AVFoundation
class ScanViewControlloerViewController: UIViewController , AVCaptureMetadataOutputObjectsDelegate{

    @IBOutlet weak var scanView: UIView!
    var data:String = ""
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialCaptureDevice()
        
        scanView.layer.borderColor = UIColor.red.cgColor
        scanView.layer.borderWidth = 1
        self.view.bringSubview(toFront: scanView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initialCaptureDevice(){
     let device = AVCaptureDevice.default(for: AVMediaType.video)
  
        do {
           
            let input = try AVCaptureDeviceInput(device: device!)
         
            captureSession = AVCaptureSession()
           
            captureSession?.addInput(input)
        }  catch  {
            
            print(error)
            return
        }
        
        
        let output = AVCaptureMetadataOutput()
        captureSession?.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.pdf417,
       ]
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        captureSession?.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if   metadataObjects.count == 0 {
            return
        }
        
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metadataObj.type == AVMetadataObject.ObjectType.qr
            || metadataObj.type == AVMetadataObject.ObjectType.ean13
            || metadataObj.type ==  AVMetadataObject.ObjectType.code128
            || metadataObj.type ==  AVMetadataObject.ObjectType.ean8
            || metadataObj.type == AVMetadataObject.ObjectType.upce
            || metadataObj.type == AVMetadataObject.ObjectType.code39
            || metadataObj.type == AVMetadataObject.ObjectType.code39Mod43
            || metadataObj.type == AVMetadataObject.ObjectType.code93
            || metadataObj.type == AVMetadataObject.ObjectType.pdf417
            
        {
            _ = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            if metadataObj.stringValue != nil {
                captureSession?.stopRunning()
                finishCapture(res:metadataObj.stringValue!)
            }
        }
    }
    
    
    func finishCapture(res:String){
         print(res)
        
        UIPasteboard.general.string = res;
        data = res
          performSegue(withIdentifier: "goSearch", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goSearch" {
            let controller = segue.destination as! MyWebViewController
            controller.data = self.data
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}
