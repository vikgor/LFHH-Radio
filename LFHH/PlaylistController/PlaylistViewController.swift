//
//  TableViewController.swift
//  LFHH
//
//  Created by Viktor Gordienko on 7/23/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import UIKit

class PlaylistViewController: UITableViewController {
    
    var interactor: PlaylistInteractor?
    let screenSize: CGRect = UIScreen.main.bounds
    
    func setup() {
        let interactor = PlaylistInteractor()
        self.interactor = interactor
        let presenter = PlaylistPresenter()
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor?.startDoingStuff()
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (interactor?.historyArray!.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        cell.textLabel?.text = String((interactor?.historyArray![indexPath.item])!)
        cell.textLabel?.textColor = .white
        return cell
    }
    
    @objc func refresh(sender:AnyObject)
    {
        interactor?.getRadioPlaylist()
        //move next two to presenter
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
        
    //    override func viewDidAppear(_ animated: Bool) {
    //        print("Getting updated playlist...")
    //        interactor?.getRadioPlaylist()
    //    }

    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        return 1
    //    }

}
