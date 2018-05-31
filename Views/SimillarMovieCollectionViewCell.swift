//
//  SimillarMovieCollectionViewCell.swift
//  MovieApp
//
//  Created by webwerks on 29/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit

class SimillarMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var lblVotes: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgPoster: UIImageView!
    
    var data:BaseModel? {
        didSet{
            if let title = data?.title {
                lblTitle.text = title
            }
            if let vote = data?.vote_count {
                lblVotes.text = "Votes: \(vote)"
            }
            if let imagaName = data?.poster_path {
                let imagepath = "\(APIConst.kMoviePosterImgURL)\(imagaName)"
                imgPoster.sd_setImage(with: URL(string: imagepath), placeholderImage: UIImage(named: "backGround"))
            }
        }
    }
}
