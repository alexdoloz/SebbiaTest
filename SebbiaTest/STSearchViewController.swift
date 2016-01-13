//
//  STSearchViewController.swift
//  SebbiaTest
//
//  Created by Alexander on 13.01.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit

class STSearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        STTwitterManager.requestTweetsWithHashtag("qwerty") { tweets, error in
            print("tweets : \(tweets), error : \(error)")
        }
    }
}
