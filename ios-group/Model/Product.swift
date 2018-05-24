//
//  Product.swift
//  group_11
//
//  Created by Christopher on 20/05/2018.
//  Copyright © 2018 Christopher. All rights reserved.
//

import UIKit


class Product :   Comparable{
 
    var id:Int?
    var name:String?
    var band:String?
    var price:Double?
    var timeExpire:Int?
    var image:UIImage?
    var mini:UIImage?
    var describe:String?
      init?() {
        
    }
    
    static func <(lhs: Product, rhs: Product) -> Bool {
        if lhs.timeExpire! < rhs.timeExpire! {
            return true
        }
        
        return false
    }
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        if lhs.timeExpire! == rhs.timeExpire! {
            return true
        }
        
        return false
    }
    
    
    func getTimeDate()->String{
        
      if  let tTime = self.timeExpire {
        
            let date = Date(timeIntervalSince1970: Double(tTime))
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let strDate = dateFormatter.string(from: date)
            return strDate
        }
        return ""
      
    }
    
    
    func createId()->Int{
        var now = time_t()
        time(&now)
         let id = Int(arc4random_uniform(UInt32(99)))
        return now + id
    }
}
