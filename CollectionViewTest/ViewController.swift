//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by belga on 29/10/15.
//  Copyright © 2015 Fidel Cornelis. All rights reserved.
//

import UIKit


let ITEM_SIZE = CGFloat(200.0)

class ViewController: UICollectionViewController {
  
  private let reuseId = "Cell"


  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    let layout : FlowLayout = self.collectionViewLayout as! FlowLayout
    layout.itemSize = CGSize(width: ITEM_SIZE, height: ITEM_SIZE)
    layout.minimumLineSpacing = 50
    let bound = self.view.bounds
    let spacingY = bound.size.height / 2 - ITEM_SIZE / 2
    let spacingX = bound.size.width / 2 - ITEM_SIZE/2
    layout.sectionInset = UIEdgeInsetsMake(spacingY, spacingX, spacingY, spacingX)
    layout.activeDistance = ITEM_SIZE
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}



extension ViewController  {
  
  //1
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  //2
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 50
  }
  
  //3
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseId, forIndexPath: indexPath) 
    cell.backgroundColor = UIColor.blackColor()
    // Configure the cell
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//    let datasetCell = collectionView.cellForItemAtIndexPath(indexPath)
    collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally , animated: true)
    
  }
  
  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    let layout : FlowLayout = self.collectionViewLayout as! FlowLayout
    let bound = self.view.bounds
    let spacingY = bound.size.height / 2 - ITEM_SIZE / 2
    let spacingX = size.width / 2 - ITEM_SIZE/2
    layout.sectionInset = UIEdgeInsetsMake(spacingY, spacingX, spacingY, spacingX)
  }
}


