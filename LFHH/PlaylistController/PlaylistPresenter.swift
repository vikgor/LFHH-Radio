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
    
    func startDoingStuff() {
        viewController?.tableView.rowHeight = (viewController?.screenSize.height)! * 0.09 //Make the 10 rows fill the entire screen
    }
    
}
