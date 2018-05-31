//
//  SearchTableViewCell.swift
//  MovieApp
//
//  Created by webwerks on 27/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet var lblReleaseDate: UILabel!
    @IBOutlet var lblTitle: UILabel!
    var cellData:BaseModel? {
        didSet{
            if let releaseDt = cellData?.release_date{
               lblReleaseDate.text = "Release Date :\(releaseDt)"
            }
            if let title = cellData?.title{
                 lblTitle.text = title
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
