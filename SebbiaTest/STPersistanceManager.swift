//
//  STPersistanceManager.swift
//  SebbiaTest
//
//  Created by Alexander on 14.01.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit
import SQLite


class STPersistanceManager {
    private(set) static var sharedManager = STPersistanceManager()
    
    private let id = Expression<Int>("id")
    private let dateString = Expression<String>("dateString")
    private let text = Expression<String>("text")
    private let userName = Expression<String>("userName")
    private let userFriendsCount = Expression<Int64>("userFriendsCount")
    private let userImageURL = Expression<String>("userImageURL")
    private let tweetsTable = Table("tweets")
    
    private var db: Connection!
    
    init?() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
            db = try Connection("\(path)/db.sqlite3")
        } catch {
            return nil
        }
    }
    
    func saveTweets(tweets: [STTweet]) {
        do {
            try db.run(tweetsTable.drop(ifExists: true))
            try db.run(tweetsTable.create() {
                t in
                t.column(id, primaryKey: .Autoincrement)
                t.column(dateString)
                t.column(text)
                t.column(userName)
                t.column(userFriendsCount)
                t.column(userImageURL)
            })
            
            for tweet in tweets {
                try db.run(tweetsTable.insert(
                    dateString <- tweet.dateString,
                    text <- tweet.text,
                    userName <- tweet.userName,
                    userFriendsCount <- Int64(tweet.userFriendsCount),
                    userImageURL <- tweet.userImageURL.absoluteString
                ))
            }
        } catch {
            print("Error saving in sqlite")
        }
    }
    
    func loadTweets() -> [STTweet] {
        var tweets: [STTweet] = []
        do {
            for tweetRow in try db.prepare(tweetsTable) {
                let tweet = STTweet()
                tweet.dateString = tweetRow[dateString]
                tweet.text = tweetRow[text]
                tweet.userName = tweetRow[userName]
                tweet.userFriendsCount = Int(tweetRow[userFriendsCount])
                tweet.userImageURL = NSURL(string: tweetRow[userImageURL])!
                tweets.append(tweet)
            }
            return tweets
        } catch {
            return []
        }
    }
}
