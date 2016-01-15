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
    var dateString: String!
    var text: String!
    
    var userName: String!
    var userFriendsCount: Int!
    var userImageURL: NSURL!
    
    override init() {}
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        dateString <- map["created_at"]
        text <- map["text"]
        
        userName <- map["user.name"]
        userFriendsCount <- map["user.friends_count"]
        userImageURL <- (map["user.profile_image_url"], URLTransform())
    }
    
    override var description: String {
        return "TWEET(\(dateString)): \(text) || from \(userName) with \(userFriendsCount) friends"
    }
}
