//
//  STTwitterManager.swift
//  SebbiaTest
//
//  Created by Alexander on 13.01.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper


class STTwitterManager {
    static let token = "Bearer AAAAAAAAAAAAAAAAAAAAADiJRQAAAAAAt%2Brjl%2Bqmz0rcy%2BBbuXBBsrUHGEg%3Dq0EK2aWqQMb15gCZNwZo9yqae0hpe2FDsS92WAu0g"
    
    static let searchURL = "https://api.twitter.com/1.1/search/tweets.json"
    
    class func requestTweetsWithHashtag(hashtag: String, completion: ([STTweet]!, NSError?) -> Void) {
        let url = NSURL(string: STTwitterManager.searchURL)!
        var searchRequest = NSMutableURLRequest(URL: url)
        searchRequest.addValue(STTwitterManager.token, forHTTPHeaderField: "Authorization")
        let params = [
            "q" : "#\(hashtag)"
        ]
        var error: NSError?
        (searchRequest, error) = Alamofire.ParameterEncoding.URL.encode(searchRequest, parameters: params)
        guard error == nil else {
            completion(nil, error)
            return
        }
        
        Alamofire.request(searchRequest).responseJSON { response in
            let json = JSON(response.result.value!)
            let jsonTweetsArray = json["statuses"]
            if let tweets: [STTweet] = Mapper<STTweet>().mapArray(jsonTweetsArray.rawValue) {
                completion(tweets, nil)
            } else {
                let error = NSError(domain: "JSON Error", code: 999, userInfo: nil)
                completion(nil, error)
            }
            
        }
    }
}
