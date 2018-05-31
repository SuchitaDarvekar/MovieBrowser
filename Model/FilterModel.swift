//
//  FilterModel.swift
//  MovieApp
//
//  Created by webwerks on 29/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation
class Filter {
    var image:String?
    var title:String?
    var method:String?
    
    init(_image:String,_title:String,_method:String) {
        image = _image
        title = _title
        method = _method
    }
}
