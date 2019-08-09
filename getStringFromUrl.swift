//
//  AppDelegate.swift
//  LFHH
//
//  Created by Viktor Gordienko on 6/30/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import UIKit



@IBOutlet weak var radioHistory: UILabel!

func getRadioHistory() {
    let myURLString = "https://8137147.xyz/1/playlist/playlist.php"
    guard let myURL = NSURL(string: myURLString) else {
        print("Error: \(myURLString) doesn't seem to be a valid URL")
        return
    }
    
    do {
        let myHTMLString = try String(contentsOf: myURL as URL)
        print("HTML : \(myHTMLString)")
        radioHistory.text = myHTMLString
    } catch let error as NSError {
        print("Error: \(error)")
    }
}
