//
//  STSearchViewController.swift
//  SebbiaTest
//
//  Created by Alexander on 13.01.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit

class STSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var tweets: [STTweet] = []
    
// MARK: Outlets
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var hashtagField: UITextField!

    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var tweetsTable: UITableView!
    @IBOutlet weak var notFoundLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
// MARK: Actions
    @IBAction func searchButtonPressed(sender: AnyObject) {
        startSearch()
    }
    
    @IBAction func hashtagChanged(sender: AnyObject) {
        updateSearchButton()
    }
    
// MARK: Helpers
    func startSearch() {
        self.view.endEditing(true)
        searchHashtag(hashtagField.text!)
    }

    func updateSearchButton() {
        searchButton.enabled = (hashtagField.text! as NSString).length != 0
    }
    
    func updateTable(message: String) {
        if tweets.count == 0 {
            tweetsTable.hidden = true
            notFoundLabel.hidden = false
            notFoundLabel.text = message
            return
        }
        tweetsTable.hidden = false
        notFoundLabel.hidden = true
        tweetsTable.reloadData()
    }
    
    func searchHashtag(hashtag: String) {
        self.beginLoading()
        STTwitterManager.requestTweetsWithHashtag(hashtag) { tweets, error in
            self.endLoading()
            self.tweets = tweets ?? []
            if self.tweets.count > 0 {
                if let persistanseManager = STPersistanceManager.sharedManager {
                    persistanseManager.saveTweets(tweets)
                }
            }
            let message = error == nil ?
                "Не нашлось твитов с хештегом #\(self.hashtagField.text!)" : "Произошла ошибка. Попробуйте еще раз"
            self.updateTable(message)
        }
    }
    
    func beginLoading() {
        self.activityIndicator.startAnimating()
        self.searchButton.enabled = false
        self.hashtagField.enabled = false
    }
    
    func endLoading() {
        self.activityIndicator.stopAnimating()
        self.searchButton.enabled = true
        self.hashtagField.enabled = true
    }
    
// MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tweet = tweets[indexPath.row]
        performSegueWithIdentifier("ShowAuthorInfo", sender: tweet)
    }
    
// MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell_id", forIndexPath: indexPath) as! STTweetCell
        let tweet = tweets[indexPath.row]
        cell.dateLabel.text = tweet.dateString
        cell.tweetTextLabel.text = tweet.text
        return cell
    }
    
// MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        startSearch()
        return true
    }
    
// MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSearchButton()
        tweetsTable.rowHeight = UITableViewAutomaticDimension
        tweetsTable.estimatedRowHeight = 120.0
        if let persistanseManager = STPersistanceManager.sharedManager {
            tweets = persistanseManager.loadTweets()
        } 
        updateTable("")
        tweetsTable.contentInset.top = heightConstraint.constant;
        tweetsTable.scrollIndicatorInsets.top = heightConstraint.constant;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let profileVC = segue.destinationViewController as! STProfileViewController
        profileVC.tweet = sender as! STTweet
    }
}
