//
//  ModelStore.swift
//  Boxes
//
//  Created by Paul Ossenbruggen on 6/26/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import Foundation

class ModelStore {
    var layoutToggle = false
    
    func items() -> [DataModel] {
        return (0..<200).map { DataModel(number: $0) }
    }
}
