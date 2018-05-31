//
//  NowPlayingCollectionViewCell.swift
//  MovieApp
//
//  Created by webwerks on 28/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit
class NowPlayingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var lbllanguage: UILabel!
    @IBOutlet var lblMovieName: UILabel!
    @IBOutlet var imgMovie: UIImageView!
    
    var cellData:BaseModel?{
        didSet{
            if let movieName = cellData?.title{
              lblMovieName.text = movieName
            }
            if let lang = cellData?.original_language{
               lbllanguage.text = lang
        }
            if let imagaName = cellData?.poster_path {
                let imagepath = "\(APIConst.kMoviePosterImgURL)\(imagaName)"
                imgMovie.sd_setImage(with: URL(string: imagepath), placeholderImage: UIImage(named: "backGround"))
            }
           
        
        }
    }
    
    
}
