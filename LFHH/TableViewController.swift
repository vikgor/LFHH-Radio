//
//  TableViewController.swift
//  LFHH
//
//  Created by Viktor Gordienko on 7/23/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
//    let myURLString = "https://8137147.xyz/1/playlist/playlist.php"
    let myURLString = "https://vivalaresistance.ru/lfhh/lfhhhistory.php"
    let screenSize: CGRect = UIScreen.main.bounds
    var historyArray: [String.SubSequence]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = screenSize.height * 0.09 //Make the 10 rows fill the entire screen
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        getRadioHistory()
    }
    
    func getRadioHistory() {
        guard let myURL = NSURL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL as URL, encoding: .windowsCP1251) //the actual playlist, in text format
            historyArray = myHTMLString.split {$0.isNewline} //playlist, converted to an array
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    @objc func refresh(sender:AnyObject)
    {
        getRadioHistory()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Getting updated playlist...")
        getRadioHistory()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        cell.textLabel?.text = String(historyArray![indexPath.item])
        cell.textLabel?.textColor = .white
        return cell
    }

}
