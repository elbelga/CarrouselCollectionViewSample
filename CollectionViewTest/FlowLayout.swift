//
//  FlowLayout.swift
//  CollectionViewTest
//
//  Created by belga on 29/10/15.
//  Copyright © 2015 Fidel Cornelis. All rights reserved.
//

import UIKit


let ACTIVE_DISTANCE = CGFloat(100.0)
let ZOOM_FACTOR = CGFloat(0.3)

class FlowLayout: UICollectionViewFlowLayout {
  
  var activeDistance : CGFloat = ACTIVE_DISTANCE
  var zoomFactor: CGFloat = ZOOM_FACTOR
  
  override init() {
      super.init()
      setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  func setup() {
    self.scrollDirection = UICollectionViewScrollDirection.Horizontal
  }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = super.layoutAttributesForElementsInRect(rect)
        var visibleRect = CGRectZero
        visibleRect.origin = (self.collectionView?.contentOffset)!
        visibleRect.size = (self.collectionView?.bounds.size)!
        for attributes in array! {
            if CGRectIntersectsRect(attributes.frame, rect) {
                let distance = CGRectGetMidX(visibleRect) - attributes.center.x
                let normalizedDistance = distance / activeDistance
                if (abs(distance) < activeDistance) {
                    let zoom = 1 + zoomFactor * (1 - abs(normalizedDistance));
                    attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                    attributes.zIndex = 1;
                }
            }
        }
        return array
    }
    
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var offsetAdjustment = CGFloat(MAXFLOAT);
        let horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView!.bounds) / 2.0);
        
        let targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView!.bounds.size.width, self.collectionView!.bounds.size.height);
        let array = super.layoutAttributesForElementsInRect(targetRect)
        
        for layoutAttributes in array! {
            let itemHorizontalCenter = layoutAttributes.center.x;
            if (abs(itemHorizontalCenter - horizontalCenter) < abs(offsetAdjustment)) {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter;
            }
        }
        return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
    }



}
