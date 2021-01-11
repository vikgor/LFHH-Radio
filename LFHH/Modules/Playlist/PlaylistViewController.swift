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
        interactor?.preparePlaylist()
        setupSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.getRadioPlaylist()
    }
    
    @objc
    func refresh(sender: AnyObject) {
        interactor?.getRadioPlaylist()
    }
    
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

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistViewModel.historyArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        cell.textLabel?.text = String((PlaylistViewModel.historyArray?[indexPath.item] ?? "Unknown song"))
        cell.textLabel?.textColor = .white
        return cell
    }
    
    /// Copy text in a cell
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        if (action.description == "copy:") {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        if (action.description == "copy:") {
            let cell = tableView.cellForRow(at: indexPath)
            UIPasteboard.general.string = cell?.textLabel?.text
        }
    }
    
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - Private Methods

private extension PlaylistViewController {
    func setupSubviews() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let screenSize: CGRect = UIScreen.main.bounds
        let tabBarHeight = tabBarController?.tabBar.frame.size.height ?? 49
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        tableView.rowHeight = (screenSize.height - statusBarHeight - tabBarHeight) / 10
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(refresh),
                                 for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.tintColor = UIColor(named: "yellow")
        
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
    }
}
