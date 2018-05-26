//
//  ProductUtils.swift
//  ios-group
//
//  Created by Christopher on 21/05/2018.
//  Copyright © 2018 Minny Lin. All rights reserved.
//

import UIKit

class ProductUtils:ProductUtilProtocols {
    
    
    func getExpireProduct()->[Product] {
        let timeStamp = Int(Date().timeIntervalSince1970)
        var data = [Product]()
        
        let allProducts = StroageUtils.getProduct()
        allProducts.forEach{ product in
            if let time = product.timeExpire {
                if time <= timeStamp {
                    data.append(product)
                }
            }
        }
        return data
    }
    
    func getUnExpireProduct()->[Product] {
        
        let timeStamp = Int(Date().timeIntervalSince1970)
        var data = [Product]()
        
        let allProducts = StroageUtils.getProduct()
        allProducts.forEach{ product in
            if let time = product.timeExpire {
                if time > timeStamp {
                    data.append(product)
                }
            }
        }
        return data
    }
    
    func getPreExpireProduct()->[Product] {
        //get almost expired product by 1 month
        let timeStamp = Int(Date().timeIntervalSince1970)
        var data = [Product]()
        
        let allProducts = StroageUtils.getProduct()
        allProducts.forEach{ product in
            if let time = product.timeExpire {
                if time - 2592000 <= timeStamp {
                    data.append(product)
                }
            }
        }
        return data
    }
    
    func removeProductById(id: Int) {
        StroageUtils.removeProductById(id: id)
    }
    
    func getProductById(id: Int) {
        StroageUtils.getProductById(id: id)
    }
    
   
    
   
    

}
