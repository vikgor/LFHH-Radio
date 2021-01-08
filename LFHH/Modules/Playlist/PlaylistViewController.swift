//
//  PlaylistViewController.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import UIKit

protocol PlaylistDisplayLogic: class {
    func reloadData()
    func endRefreshing()
}

final class PlaylistViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let screenSize: CGRect = UIScreen.main.bounds
    private let viewModel = PlaylistViewModel()
    
    var interactor: PlaylistBusinessLogic?
    var router: PlaylistRoutingLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        PlaylistConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        PlaylistConfigurator.shared.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.startDoingStuff()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl?.addTarget(self,
                                            action: #selector(refresh),
                                            for: UIControl.Event.valueChanged)
        
        //TODO: - Make the 10 rows fill the entire screen
        tableView.rowHeight = screenSize.height * 0.09
        
    }
    
    @objc
    func refresh(sender: AnyObject) {
        interactor?.getRadioPlaylist()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Getting updated playlist...")
        interactor?.getRadioPlaylist()
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
}

// MARK: - PlaylistDisplayLogic

extension PlaylistViewController: PlaylistDisplayLogic {
    func reloadData() {
        tableView.reloadData()
    }
    
    func endRefreshing() {
        tableView.refreshControl?.endRefreshing()
    }
}

// MARK: - Private Methods

private extension PlaylistViewController {
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return (interactor?.historyArray!.count)!
        return PlaylistViewModel.historyArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        cell.textLabel?.text = String((PlaylistViewModel.historyArray?[indexPath.item] ?? "Unknown song"))
        cell.textLabel?.textColor = .white
        return cell
    }
}
