//
//  Product.swift
//  group_11
//
//  Created by Christopher on 20/05/2018.
//  Copyright © 2018 Christopher. All rights reserved.
//

import UIKit
enum ProductKind{
    case skinWater
    case other
}

class Product : Codable , Comparable{
 
    var expire:Boolean?
    var name:String?
    var band:String?
    var price:Double?
    var time:Data?
    var image:String?
    var kind:ProductKind?
    var describe:String?
      init(expire:Data?) {
        self.expire = expire
    }
    
    static func <(lhs: Product, rhs: Product) -> Bool {
        if lhs.score! < rhs.score! {
            return true
        }
        
        return false
    }
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        if lhs.score! == rhs.score! {
            return true
        }
        
        return false
    }
}
