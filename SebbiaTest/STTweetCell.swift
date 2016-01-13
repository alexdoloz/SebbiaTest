//
//  STTweetCell.swift
//  SebbiaTest
//
//  Created by Alexander on 14.01.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit

class STTweetCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
}
