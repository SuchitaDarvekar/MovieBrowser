//
//  ComingSoonTableViewCell.swift
//  MovieApp
//
//  Created by webwerks on 28/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit

class ComingSoonTableViewCell: UITableViewCell {

    @IBOutlet var lblReleaseDt: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgView: UIImageView!
    
    var data:BaseModel?{
        didSet{
            lblTitle.text = data?.title
            lblReleaseDt.text = data?.release_date
            if let imagaName = data?.poster_path {
                let imagepath = "\(APIConst.kMoviePosterImgURL)\(imagaName)"
                imgView.sd_setImage(with: URL(string: imagepath), placeholderImage: UIImage(named: "backGround"))
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
