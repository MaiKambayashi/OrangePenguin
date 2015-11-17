//
//  Image.swift
//  OrangePenguin
//
//  Created by mai.kambayashi on 2015/11/17.
//  Copyright © 2015年 mai.kambayashi. All rights reserved.
//

import Foundation

class Image {
    let height: Double
    let width: Double
    let url: NSURL
    
    init(dictionary: Dictionary<String, AnyObject>) {
        height = (dictionary["height"] as! NSString).doubleValue
        width = (dictionary["width"] as! NSString).doubleValue
        url = NSURL(string: dictionary["url"] as! String)!
    }
}
