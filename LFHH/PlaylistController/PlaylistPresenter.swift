//
//  PlaylistPresenter.swift
//  LFHH
//
//  Created by Viktor Gordienko on 10/27/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import Foundation

class PlaylistPresenter {
    
    var viewController: TableViewController?
    
    func startDoingStuff() {
        
        

    }
    
    @objc func refresh(sender:AnyObject)
    {
//        getRadioHistory()
        viewController?.tableView.reloadData()
        viewController?.refreshControl?.endRefreshing()
    }
    
}
