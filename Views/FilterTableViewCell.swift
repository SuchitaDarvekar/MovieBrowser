//
//  FilterTableViewCell.swift
//  MovieApp
//
//  Created by webwerks on 29/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet var imgCheck: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
