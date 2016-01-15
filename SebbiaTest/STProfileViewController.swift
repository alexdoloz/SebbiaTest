//
//  STProfileViewController.swift
//  SebbiaTest
//
//  Created by Alexander on 13.01.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit
import Haneke

class STProfileViewController: UIViewController {
    var tweet: STTweet!
    
// MARK: Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userFriendsCountLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
// MARK: Lifecycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        userNameLabel.text = tweet.userName
        userFriendsCountLabel.text = String(tweet.userFriendsCount)
        profileImageView.hnk_setImageFromURL(tweet.userImageURL, failure: {
            error in
            self.activityIndicator.stopAnimating()
        }, success: {
            image in
            self.activityIndicator.stopAnimating()
            self.profileImageView.image = image
        })
    }
    
}
