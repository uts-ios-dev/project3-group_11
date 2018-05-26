//
//  StroageUtils.swift
//  group_11
//
//  Created by Christopher on 20/05/2018.
//  Copyright © 2018 Christopher. All rights reserved.
//

import UIKit

class StroageUtils: NSObject {
    static func saveProduct(product:Product ){
        
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        appDelegate.products.append(product)
    }
    
     static func getProduct()->[Product]{
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        return appDelegate.products
    }
    
    static func removeProductById(id: Int){
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        if let index = appDelegate.products.index(where: { $0.id == id }) {
            appDelegate.products.remove(at: index)
        }
    }
    
    static func getProductById(id: Int)-> Product{
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        let index = appDelegate.products.index(where: { $0.id == id })
        return appDelegate.products[index!]
    }
    
//static let PRODUCT_KEY : String = "PRODUCT_KEY"
//    static func loadProduct() -> [Product]?{
//
//
//        let  list =    UserDefaults.standard.array(forKey: PRODUCT_KEY)  as? [Data]
//        var returnList :[Product] = []
//
//        guard list != nil else{
//            return returnList
//        }
//
//        for t in list! {
//            let decoder = JSONDecoder()
//            let record = try? decoder.decode(Product.self, from: t as! Data)
//            returnList.append(record!)
//        }
//        returnList.sort(by:>)
//        return returnList
//    }
//
//    static func saveScoreList(record: Product) {
//
//        var list =  (UserDefaults.standard.array(forKey: PRODUCT_KEY) as? [Data])
//
//        if list == nil {
//            var newList : [Any] = []
//            let encoder = JSONEncoder()
//            let encoded = try?encoder.encode(record)
//            newList.append(encoded as! Data)
//
//
//            UserDefaults.standard.set(   newList, forKey: PRODUCT_KEY)
//
//        } else {
//
//            let encoder = JSONEncoder()
//            let encoded = try?encoder.encode(record)
//            list!.append(encoded as! Data)
//            UserDefaults.standard.set(  list, forKey: PRODUCT_KEY)
//        }
//
//    }
}
