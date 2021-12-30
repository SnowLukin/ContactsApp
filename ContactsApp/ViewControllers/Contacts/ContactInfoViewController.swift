//
//  ContactInfoViewController.swift
//  ContactsApp
//
//  Created by Snow Lukin on 29.12.2021.
//

import UIKit

class ContactInfoViewController: UITableViewController {
    
    var contact: Person!
    private var contactInfoSections = [[String]]()
    
    fileprivate let cellIdentifier = "infoCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = contact.fullName
        
        contactInfoSections = [
            [contact.sex.rawValue],
            [getSex(contact.sex)],
            [contact.phoneNumber],
            [contact.email]
        ]
        
        tableView.allowsSelection = false
    }
    
    private func getSex(_ sex: Person.Sex) -> String {
        switch sex {
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
}

extension ContactInfoViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewHeaderFooterView()
        
        // Content
        var content = header.defaultContentConfiguration()
        content.textProperties.color = UIColor(red: 0.983, green: 0.891, blue: 0.600, alpha: 1)
        
        switch section {
        case 0:
            content.text = ""
        case 1:
            content.text = "Sex"
        case 2:
            content.text = "Phone Number"
        default:
            content.text = "Email"
        }
        
        header.contentConfiguration = content
        
        return header
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        contactInfoSections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactInfoSections[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Image Cell
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageViewCell
            // setting corner radius in case we get square image (not default)
            cell.contactImageView.layer.cornerRadius = cell.contactImageView.frame.width / 2
            cell.contactImageView.image = UIImage(named: contactInfoSections[indexPath.section][indexPath.row])
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Content
        var content = cell.defaultContentConfiguration()
        // made that so futher it can be used with multiple rows in sections
        content.text = contactInfoSections[indexPath.section][indexPath.row]
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 18)
        content.textProperties.color = .black
        cell.contentConfiguration = content
        
        cell.backgroundColor = UIColor(red: 0.983, green: 0.891, blue: 0.600, alpha: 1)
        
        return cell
    }
    
}
