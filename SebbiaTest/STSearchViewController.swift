//
//  STSearchViewController.swift
//  SebbiaTest
//
//  Created by Alexander on 13.01.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit

class STSearchViewController: UIViewController {
// MARK: Outlets
    
    @IBOutlet weak var hashtagField: UITextField!

    @IBOutlet weak var searchButton: UIButton!
    
// MARK: Actions
    @IBAction func searchButtonPressed(sender: AnyObject) {
        searchHashtag(hashtagField.text!)
    }
    
    @IBAction func hashtagChanged(sender: AnyObject) {
        print("\(hashtagField.text!)")
        updateSearchButton()
    }
    
// MARK: Helpers
    func updateSearchButton() {
        searchButton.enabled = (hashtagField.text! as NSString).length != 0
    }
    
    func searchHashtag(hashtag: String) {
        STTwitterManager.requestTweetsWithHashtag(hashtag) { tweets, error in
            print("tweets : \(tweets), error : \(error)")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSearchButton()
    }
}
