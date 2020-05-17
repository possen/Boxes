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
    var columns: Int = 0
    var modelStore: ModelStore
    
    init(modelStore: ModelStore) {
        self.modelStore = modelStore
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func layoutsForRange(start: Int, end: Int) -> [UICollectionViewLayoutAttributes] {
        var layouts : [UICollectionViewLayoutAttributes] = []

        for item in start..<end {
            let row = (item / columns)
            let column = (item % columns)
            let col = !modelStore.layoutToggle || row % 2 == 0 ? column : columns - 1 - column
            
            let layoutFrame = CGRect(x: CGFloat(col) * cellSize,
                                     y: CGFloat(row) * cellSize,
                                     width: cellSize,
                                     height: cellSize)
            let layout = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: item, section: 0))
            layout.frame = layoutFrame
            layouts.append(layout)
        }
        return layouts
    }
    
    override func prepare() {
        if let cv = self.collectionView {
            columns = Int(cv.frame.width / cellSize)
        }
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let y = min(max(0, rect.origin.y), collectionViewContentSize.height)
        let h = min(collectionViewContentSize.height, y + rect.size.height)
        let itemCount = collectionView?.numberOfItems(inSection: 0) ?? 0
        let start = y / cellSize
        let end = h / cellSize
        let s = Int(start) * columns
        let e = min(Int(end) * columns, itemCount)
        return layoutsForRange(start: min(s, e), end: e)
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutsForRange(start: indexPath.row, end: indexPath.row+1)[0]
    }
    
    override var collectionViewContentSize: CGSize {
        if let cv = self.collectionView, columns != 0 {
            let count = ceil(CGFloat(cv.numberOfItems(inSection: 0)) / CGFloat(columns))
            return CGSize(width: cv.frame.width, height: cellSize * count)
        }
        return CGSize()
    }
}
