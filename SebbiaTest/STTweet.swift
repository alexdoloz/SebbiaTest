//
//  STTweet.swift
//  SebbiaTest
//
//  Created by Alexander on 13.01.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit
import ObjectMapper

class STTweet: NSObject, Mappable {
    var date: NSDate!
    var text: String!
    
    var userName: String!
    var userFriendsCount: Int!
    var userImageURL: NSURL!
    
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
        date <- (map["created_at"], DateFormatterTransform(dateFormatter: dateFormatter))
        text <- map["text"]
        
        userName <- map["user.name"]
        userFriendsCount <- map["user.friends_count"]
        userImageURL <- (map["user.profile_image_url"], URLTransform())
    }
    
    override var description: String {
        return "TWEET(\(date)): \(text) || from \(userName) with \(userFriendsCount) friends"
    }
}
