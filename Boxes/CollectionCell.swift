//
//  CollectionCell.swift
//  Boxes
//
//  Created by Paul Ossenbruggen on 6/26/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var numberView: UILabel!
    
    struct ViewData {
        let index: Int
        let result: DataModel
    }
    
    var viewData: ViewData? {
        didSet {
            if let viewData = viewData {
                numberView.text = "\(viewData.result.number)"
            }
        }
    }
}

extension CollectionCell.ViewData {
    init(model: DataModel, index: Int) {
        self.result = model
        self.index = index
    }
}



