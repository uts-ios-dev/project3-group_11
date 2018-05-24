//
//  NewItemViewController.swift
//  ios-group
//
//  Created by Christopher on 24/05/2018.
//  Copyright © 2018 Minny Lin. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photo: UIButton!
    @IBOutlet weak var camera: UIButton!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func saveItem(_ sender: Any) {
        
        if image == nil {
            return
        }
        
        
        var product =   Product()
        
    
        
    }
    @IBAction func tapPhoto(_ sender: Any) {
       
         getImage(type:.photoLibrary)
    }
    
    @IBAction func tapCamera(_ sender: Any) {
     
        getImage(type:.camera)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let tImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image.image = tImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func getImage(type:UIImagePickerControllerSourceType){
        
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = type
        present(picker, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
