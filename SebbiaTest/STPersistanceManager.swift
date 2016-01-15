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
    class func saveTweets(tweets: [STTweet], hashtag: String) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
            let db = try Connection("\(path)/db.sqlite3")
            
            let id = Expression<Int>("id")
            let dateString = Expression<String>("dateString")
            let text = Expression<String>("text")
            let userName = Expression<String>("userName")
            let userFriendsCount = Expression<Int64>("userFriendsCount")
            let userImageURL = Expression<String>("userImageURL")
            
            let tweetsTable = Table("tweets")
            let sql = tweetsTable.create(ifNotExists: true) {
                t in
                t.column(id, primaryKey: .Autoincrement)
                t.column(dateString)
                t.column(text)
                t.column(userName)
                t.column(userFriendsCount)
                t.column(userImageURL)

//                t.primaryKey(dateString, userName)
            }
            try! db.run(sql)
            
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
    
    class func loadTweets() -> ([STTweet], String) {
        return ([], "")
    }
}
