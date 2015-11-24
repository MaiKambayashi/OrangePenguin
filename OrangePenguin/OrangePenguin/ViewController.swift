//
//  ViewController.swift
//  OrangePenguin
//
//  Created by mai.kambayashi on 2015/11/10.
//  Copyright © 2015年 mai.kambayashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    @IBOutlet weak var collectionView: UICollectionView!
    var imageList: Array<Image> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        ImageManager().fetchImageList { (array, error) -> Void in
            self.imageList = array
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.collectionView.reloadData()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        
        let imageEntity = imageList[indexPath.item]
        let url = imageEntity.url
        ImageManager().fetchImageData(url) { (image, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let imageView = cell.contentView.viewWithTag(1) as! UIImageView
                imageView.image = image
            })
        }
        return cell        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = mainStoryboard.instantiateViewControllerWithIdentifier("rootViewController")
        self.presentViewController(rootViewController, animated: true, completion: nil)
    }
}

