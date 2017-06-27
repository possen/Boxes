//
//  ViewController.swift
//  Boxes
//
//  Created by Paul Ossenbruggen on 6/26/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    var cellCollectionViewAdaptor: CollectionViewAdaptor!
    var cellAdaptorSection: CollectionViewAdaptorSection<CollectionCell, DataModel>!
    var modelStore = ModelStore()
    @IBOutlet weak var toggle: UIBarButtonItem!
    
    @IBAction func toggleAction(_ sender: Any) {
        modelStore.layoutToggle = !modelStore.layoutToggle
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellAdaptorSection = CollectionViewAdaptorSection<CollectionCell, DataModel> (
            cellReuseIdentifier: "CollectionCell",
            cellSize: CGSize(width: cellSize, height: cellSize),
            items: modelStore.items() )
        { cell, model, index in
            cell.viewData = CollectionCell.ViewData(model: model, index: index)
        }
        collectionView?.collectionViewLayout = WrapBackAndForthLayout(modelStore: modelStore)
        
        cellCollectionViewAdaptor = CollectionViewAdaptor (
            collectionView: collectionView!,
            sections: [cellAdaptorSection]) { [unowned self] in
                self.collectionView?.reloadData()
        }
    }
}

