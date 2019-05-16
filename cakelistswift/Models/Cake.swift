//
//  Cake.swift
//  cakelistswift
//
//  Created by Charlie Finlayson on 16/05/2019.
//  Copyright © 2019 Charlie Finlayson. All rights reserved.
//

import UIKit

struct Cake {
    var title: String?
    var description: String?
    var imageUrl: String?
    	
    init(_ dictionary: [String: String]) {
        title = dictionary["title"]
        description = dictionary["desc"]
        imageUrl = dictionary["image"]
    }
}
