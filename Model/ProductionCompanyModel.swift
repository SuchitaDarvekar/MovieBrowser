//
//  ProductionCompanyModel.swift
//  MovieApp
//
//  Created by webwerks on 27/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation
class ProductionCompany{
    var id :Int?
    var logoPath:String?
    var name:String?
    var origin_country:String?
    
    init(jsonObject:[String:AnyObject]) {
        id = jsonObject[JsonResponseConstants.kId] as? Int
        logoPath = jsonObject[JsonResponseConstants.kLogoPath] as? String
        name = jsonObject[JsonResponseConstants.kName] as? String
        origin_country = jsonObject[JsonResponseConstants.kOriginCountry] as? String

    }
}
