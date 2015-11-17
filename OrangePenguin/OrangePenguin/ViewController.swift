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
        let data = NSData(contentsOfURL: url)
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(data: data!)
        return cell        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.item)
    }
}

