//
//  STSearchViewController.swift
//  SebbiaTest
//
//  Created by Alexander on 13.01.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit

class STSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tweets: [STTweet] = []
    
// MARK: Outlets
    
    @IBOutlet weak var hashtagField: UITextField!

    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var tweetsTable: UITableView!
    
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
            self.tweets = tweets
            self.tweetsTable.reloadData()
        }
    }
    
// MARK: UITableViewDelegate
    
// MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell_id", forIndexPath: indexPath) as! STTweetCell
        let tweet = tweets[indexPath.row]
        cell.dateLabel.text = tweet.date.description
        cell.tweetTextLabel.text = tweet.text
        return cell
    }
    
// MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSearchButton()
        tweetsTable.rowHeight = UITableViewAutomaticDimension
        tweetsTable.estimatedRowHeight = 120.0
    }
}
