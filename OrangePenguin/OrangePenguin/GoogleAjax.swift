//
//  SearchImage.swift
//  OrangePenguin
//
//  Created by mai.kambayashi on 2015/11/16.
//  Copyright © 2015年 mai.kambayashi. All rights reserved.
//

import Foundation

class GoogleAjax {
    func searchImage(callbackHandler: (dictionary: Dictionary<String, AnyObject>, error: NSError?) -> Void) -> Void {
        let url:NSURL! = NSURL(string: "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=%E3%83%9A%E3%83%B3%E3%82%AE%E3%83%B3&rsz=8")
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            let dictionary: Dictionary = self.deserializeToDictionary(data!)!
            callbackHandler(dictionary: dictionary, error: error)
        }
        task.resume()
    }
    
    private func deserializeToDictionary(data: NSData) -> Dictionary<String, AnyObject>? {
        do {
            return try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? Dictionary
        } catch {
            return nil
        }
    }
}
