//
//  NewItemViewController.swift
//  ios-group
//
//  Created by Christopher on 24/05/2018.
//  Copyright © 2018 Minny Lin. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var photo: UIButton!
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var image: UIImageView!
    
    //Detial information
    @IBOutlet weak var productIDField: UITextField!
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var expireDateField: UITextField!
    let datePicker = UIDatePicker()
    @IBOutlet weak var descriptionField: UITextField!
    
    override func viewDidLoad() {
        productIDField.delegate = self
        productNameField.delegate = self
        brandField.delegate = self
        priceField.delegate = self
        expireDateField.delegate = self
        descriptionField.delegate = self
        
        super.viewDidLoad()
        createDatePicker()// create datepick for expireField
        // Do any additional setup after loading the view.
    }
    
    
    
    
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
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        //keyboard return problem
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case productIDField:
            productNameField.becomeFirstResponder()
        case productNameField:
            brandField.becomeFirstResponder()
        case brandField:
            priceField.becomeFirstResponder()
        case priceField:
            expireDateField.becomeFirstResponder()
        case expireDateField:
            descriptionField.becomeFirstResponder()
        case descriptionField:
            self.view.endEditing(true)
        default:
                self.view.endEditing(true)
        }
        return true
        //keyboard return problem
    }
    
    //Create date picker for the input of expire date
    func createDatePicker(){
        // toolbar
        let dateToolbar = UIToolbar()
        dateToolbar.sizeToFit()
        
        //done button
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePickerDonePress))
        dateToolbar.setItems([done], animated: false)
        expireDateField.inputAccessoryView = dateToolbar
        expireDateField.inputView = datePicker
        
        //format picker for date
        datePicker.datePickerMode = .date
        
    }
    // done function in datepicker toolbar
    @objc func datePickerDonePress(){
        // format date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM/dd/yyyy"
        let dateString = formatter.string(from: datePicker.date)
        
        expireDateField.text = "\(dateString)"
        self.view.endEditing(true)
        
    }
    // only number is allowed for priceField
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let allowedCharacters = "1234567890."
//        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
//        let typeCharacterSet = CharacterSet(charactersIn: string)
//
//        return allowedCharacterSet.isSuperset(of: typeCharacterSet)
//    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
