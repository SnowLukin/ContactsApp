//
//  ExpendedContactListViewController.swift
//  ContactsApp
//
//  Created by Snow Lukin on 29.12.2021.
//

import UIKit

class ExpendedContactListViewController: UITableViewController {
    
    var contacts: [Person]!
    fileprivate var cellIdentifier = "expandedInfoCell"
    
}

extension ExpendedContactListViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let contact = contacts[section]
        let header = UITableViewHeaderFooterView()
        
        // Content
        var content = header.defaultContentConfiguration()
        content.textProperties.color = UIColor(red: 0.983, green: 0.891, blue: 0.600, alpha: 1)
        
        content.text = contact.name + " " + contact.surname
        
        header.contentConfiguration = content
        
        return header
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        contacts.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Contact
        let contact = contacts[indexPath.section]
        let yelloweCollor = UIColor(red: 0.983, green: 0.891, blue: 0.600, alpha: 1)
        var content = cell.defaultContentConfiguration()
        
        // Text & Image
        switch indexPath.row {
        case 0:
            content.text = contact.phoneNumber
            content.image = UIImage(systemName: "phone")
        default:
            content.text = contact.email
            content.image = UIImage(systemName: "tray")
        }
        content.imageProperties.tintColor = yelloweCollor
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 18)
        content.textProperties.color = .white
        
        cell.contentConfiguration = content
        
        // background color when selected
        let selectedView = UIView()
        selectedView.backgroundColor = yelloweCollor
        cell.selectedBackgroundView = selectedView
        selectedView.sizeToFit()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
