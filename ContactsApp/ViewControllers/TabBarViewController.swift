//
//  TabBarViewController.swift
//  ContactsApp
//
//  Created by Snow Lukin on 27.12.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private var person = Person.getPersonsInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adding top border to tabbar
        addTabBarTopLine()
        // pass data
        sharePersonsInfo()
    }
    
    private func sharePersonsInfo() {
        guard let viewControllers = viewControllers else { return }
        for viewController in viewControllers {
            if let navVC = viewController as? UINavigationController {
                if let contactVC = navVC.topViewController as? ContactListViewController {
                    contactVC.contacts = person
                }
                if let expendedContactVC = navVC.topViewController as? ExpendedContactListViewController {
                    expendedContactVC.contacts = person
                }
            }
        }
    }
    
    
    private func addTabBarTopLine() {
        let lineView = UIView(
            frame: CGRect(x: 0, y: 0,width: UIScreen.main.bounds.width, height: 0.3)
        )
        lineView.backgroundColor = .gray
        tabBar.addSubview(lineView)
    }
}

