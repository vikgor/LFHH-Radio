//
//  PlaylistPresenter.swift
//  LFHH
//
//  Created by Viktor Gordienko on 10/27/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import Foundation
import UIKit

class PlaylistPresenter {
    
    var viewController: PlaylistViewController?
    
    func refresh() {
        viewController?.tableView.reloadData()
        viewController?.refreshControl?.endRefreshing()
    }
    
}
