//
//  WrapLayout.swift
//  Boxes
//
//  Created by Paul Ossenbruggen on 6/26/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import UIKit

let cellSize: CGFloat = 60.0

class WrapBackAndForthLayout: UICollectionViewLayout {
    var layouts : [UICollectionViewLayoutAttributes] = []
    var columns: Int = 0
    
    override func prepare() {
        layouts = []
        if let cv = self.collectionView  {
            let count = cv.numberOfItems(inSection: 0)
            columns = Int(cv.frame.width / cellSize)
            
            for vert in 0..<count {
                let row = (vert / columns)
                let column = (vert % columns)
                let c = row % 2 == 0 ? column : columns - 1 - column
                
                let layoutFrame = CGRect(x: CGFloat(c) * cellSize,
                                         y: CGFloat(row) * cellSize,
                                         width: cellSize,
                                         height: cellSize)
                
                let layout = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: vert, section: 0))
                layout.frame = layoutFrame
                layouts.append(layout)
            }
        }
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layouts
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layouts[indexPath.row]
    }
    
    override var collectionViewContentSize: CGSize {
        if let cv = self.collectionView, columns != 0 {
            let count = ceil(CGFloat(cv.numberOfItems(inSection: 0)) / CGFloat(columns))
            return CGSize(width: cv.frame.width, height: cellSize * count)
        }
        return CGSize()
    }
}
