//
//  EditViewController.swift
//  ios-group
//
//  Created by Christopher on 02/06/2018.
//  Copyright © 2018 Minny Lin. All rights reserved.
//

import UIKit

class EditViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var galary: UIButton!
    @IBOutlet weak var ca: UIButton!
    
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var brand: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var expireDate: UITextField!
    @IBOutlet weak var dec: UITextField!
    
    var id :Int!
    
      let datePicker = UIDatePicker()
    override func viewDidLoad() {
        
        productName.delegate = self
        brand.delegate = self
        price.delegate = self
        expireDate.delegate = self
        dec.delegate = self
        
        
        
        super.viewDidLoad()
        createDatePicker()
        // Do any additional setup after loading the view.
    }
    var isFirst:Bool = true
    override func viewWillAppear(_ animated: Bool) {
        
        
        if isFirst == true {
            let product =   StroageUtils.getProductById(id: id)
            photo.image  = UIImage(contentsOfFile:product.image!)
            productName.text = product.name
            brand.text = product.band
            price.text = String(format:"%f", product.price!)
            dec.text = product.describe
            
            let unixTimestamp = product.timeExpire!
            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
            
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.dateFormat = "MM/dd/yyyy"
            let dateString = formatter.string(from:date)
            
            expireDate.text = "\(dateString)"
            isFirst = false
        }
     
    }
    @IBAction func SaveItem(_ sender: Any) {
        
                if photo == nil {
                    return
                }
        if (self.productName.text == "" || expireDate.text == nil) {
            let alertView = UIAlertController(title: "Error", message: "ProductName is necessary", preferredStyle: .alert)
            let confirmBtn = UIAlertAction(title: "Ok", style: .default) { (action) in
                return}
            alertView.addAction(confirmBtn)
            present(alertView, animated:true, completion:nil)
            return
        }
        if (expireDate.text == "" || expireDate.text == nil) {
            let alertView = UIAlertController(title: "Error", message: "ExpireDate is necessary", preferredStyle: .alert)
            let confirmBtn = UIAlertAction(title: "Ok", style: .default) { (action) in
                return}
            alertView.addAction(confirmBtn)
            present(alertView, animated:true, completion:nil)
            return
        }
        let productName = self.productName.text
        let productBrand = brand.text ?? "none"
        let productPrice = ((price.text)! as NSString).doubleValue
        let expiredate = getTimeStamp(expiredDate: expireDate.text!)
        
        
        
        
        let productDescription = dec.text ?? "none"
        
        let product =   Product(name: productName!, band: productBrand, price: (productPrice), timeExpire: expiredate, image: photo, describe: productDescription)
        StroageUtils.saveProduct(product: product!)
        
        StroageUtils.removeProductById(id: id)
        
        // show alert info
        let alertView = UIAlertController(title: "Edit item", message: "The item is saved", preferredStyle: .alert)
        let confirmBtn = UIAlertAction(title: "Confirm", style: .default) { (action) in
//            let storyBoard:UIStoryboard = UIStoryboard(name:"Main", bundle :nil)
//            let EditViewController = storyBoard.instantiateViewController(withIdentifier: "mainView")
//            self.navigationController?.pushViewController(EditViewController, animated: true)
              self.navigationController?.popToRootViewController(animated: true)
           
        }
        alertView.addAction(confirmBtn)
        present(alertView, animated:true, completion:nil)
        
        
    }
    
   
    
    @IBAction func tapPhoto(_ sender: Any) {
            getImage(type:.photoLibrary)
    }
    
    @IBAction func tapCamera(_ sender: Any) {
          getImage(type:.camera)
    }
    func getImage(type:UIImagePickerControllerSourceType){
        
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = type
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let tImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
           
         photo.image = tImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
        case productName:
            brand.becomeFirstResponder()
        case brand:
            price.becomeFirstResponder()
        case price:
            expireDate.becomeFirstResponder()
        case expireDate:
            dec.becomeFirstResponder()
        case dec:
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
        expireDate.inputAccessoryView = dateToolbar
        expireDate.inputView = datePicker
        
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
        
        expireDate.text = "\(dateString)"
        self.view.endEditing(true)
        
    }
    
    // get the timestamp of expired date
    func getTimeStamp(expiredDate:String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let expiredate = dateFormatter.date(from: expiredDate)
        
        let timeStamp = Int((expiredate?.timeIntervalSince1970)!)
        return timeStamp
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
