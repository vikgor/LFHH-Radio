//
//  TabBarViewController.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import UIKit

protocol TabBarDisplayLogic: class {
    
}

final class TabBarViewController: UITabBarController {
    
    private var lineView = UIView()
    private var leftLineConstraint = NSLayoutConstraint()
    
    private let defaults : UserDefaults = .standard
    
    var interactor: TabBarBusinessLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        TabBarConfigurator.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        TabBarConfigurator.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        updateLinePosition(tabBar.items?.firstIndex(of: item))
    }
    
    // MARK: - Public methods
    
}

// MARK: - TabBarDisplayLogic

extension TabBarViewController: TabBarDisplayLogic {
    
}

// MARK: - Helpers

private extension TabBarViewController {
    func setupSubviews() {
        createTabs()
        setupTabBar()
        setupLine()
    }
    
    func setupTabBar() {
        self.tabBar.tintColor = UIColor(named: "yellow")
        self.tabBar.layer.masksToBounds = false
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
        self.tabBar.items?.forEach { $0.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0) }
    }
    
    func setupLine() {
        lineView.layer.cornerRadius = 4
        lineView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        lineView.backgroundColor = UIColor(named: "yellow")
        self.tabBar.addSubview(lineView)

        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        leftLineConstraint = lineView.leftAnchor.constraint(equalTo: self.tabBar.leftAnchor, constant: 0)
        leftLineConstraint.isActive = true
        lineView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
        lineView.topAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: 0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    func updateLinePosition(_ index: Int?) {

        guard let index = index else {
            lineView.alpha = 0
            return
        }
        
        let width = Int(UIScreen.main.bounds.width) / 3
        let leftSpacing = (index * width)
        
        leftLineConstraint.constant = CGFloat(leftSpacing)
        leftLineConstraint.isActive = true
        
        UIView.animate(withDuration: 0.3) {
            self.tabBar.layoutIfNeeded()
        }
    }
    
    //tabs
    func createTabs() {
        let player = createPlayerTab()
        let timer = createTimerTab()
        let playlist = createPlaylistTab()
        
        viewControllers = [player,
                           timer,
                           playlist]
    }
    
    func createPlayerTab() -> UIViewController {
        guard let viewController = UIStoryboard(name: "Player", bundle: nil).instantiateViewController(withIdentifier: "Player") as? PlayerViewController else {
            fatalError("Couldn't instantiate Player view controller")
        }
        
        let navigation = UINavigationController(rootViewController: viewController)
        
        navigation.setNavigationBarHidden(true, animated: true)
        navigation.tabBarItem = UITabBarItem(
            title: nil,
            image: #imageLiteral(resourceName: "music-player"),
            selectedImage: #imageLiteral(resourceName: "music-player"))
        
        return navigation
    }
    
    func createTimerTab() -> UIViewController {
        guard let viewController = UIStoryboard(name: "Timer", bundle: nil).instantiateViewController(withIdentifier: "Timer") as? TimerViewController else {
            fatalError("Couldn't instantiate Timer view controller")
        }
        let navigation = UINavigationController(rootViewController: viewController)

        navigation.setNavigationBarHidden(true, animated: true)
        navigation.tabBarItem = UITabBarItem(
            title: nil,
            image: #imageLiteral(resourceName: "stopwatch"),
            selectedImage: #imageLiteral(resourceName: "stopwatch"))
        
        return navigation
    }
    
    func createPlaylistTab() -> UIViewController {
        guard let viewController = UIStoryboard(name: "Playlist", bundle: nil).instantiateViewController(withIdentifier: "Playlist") as? PlaylistViewController else {
            fatalError("Couldn't instantiate Playlist view controller")
        }
        let navigation = UINavigationController(rootViewController: viewController)
        
        navigation.setNavigationBarHidden(true, animated: true)
        navigation.tabBarItem = UITabBarItem(
            title: nil,
            image: #imageLiteral(resourceName: "file"),
            selectedImage: #imageLiteral(resourceName: "file"))
        
        return navigation
    }
}
