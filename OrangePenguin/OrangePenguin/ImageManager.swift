//
//  ImageManager.swift
//  OrangePenguin
//
//  Created by mai.kambayashi on 2015/11/17.
//  Copyright © 2015年 mai.kambayashi. All rights reserved.
//

import Foundation
import UIKit

class ImageManager {
    func fetchImageList(callbackHandler: (array: Array<Image>, error: NSError?) -> Void) -> Void {
        GoogleAjax().searchImage { (dictionary, error) -> Void in
            var images: Array<Image> = []
            for dic in dictionary["responseData"]!["results"] as! Array<AnyObject> {
                images.append(Image(dictionary: dic as! Dictionary<String, AnyObject>))
            }
            callbackHandler(array: images, error: error)
         }
    }
    
    func fetchImageData(url: NSURL, callbackHandler: (image: UIImage, error: NSError?) -> Void) ->
        Void {
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            
            let task = session.dataTaskWithURL(url) {
                (data, response, error) -> Void in
                let image = UIImage(data: data!)
                callbackHandler(image: image!, error: error)
            }
            task.resume()
    }
}
