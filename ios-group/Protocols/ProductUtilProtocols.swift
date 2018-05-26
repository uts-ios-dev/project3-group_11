//
//  ProductProtocols.swift
//  ios-group
//
//  Created by Christopher on 21/05/2018.
//  Copyright © 2018 Minny Lin. All rights reserved.
//

import UIKit
 
protocol ProductUtilProtocols {

    func getExpireProduct()->[Product]
    func getUnExpireProduct()->[Product]
    func getPreExpireProduct()->[Product]
    func removeProductById(id:Int)
    func getProductById(id:Int)
}

