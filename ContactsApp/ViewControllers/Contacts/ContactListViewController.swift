//
//  ContactListViewController.swift
//  ContactsApp
//
//  Created by Snow Lukin on 29.12.2021.
//

import UIKit

class ContactListViewController: UITableViewController {
    
    // MARK: Properties
    var searchCoontroller: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.barStyle = .black
        
        return searchController
    }()
    
    var contacts: [Person]!
    var filteredContacts: [Person]!
    
    fileprivate let cellIdentifier = "contactListCell"
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredContacts = contacts.sorted(by: { $0.name < $1.name })
        
        searchCoontroller.searchResultsUpdater = self
        navigationItem.searchController = searchCoontroller
    }
    
    // MARK: Override Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let contactInfoVC = segue.destination as? ContactInfoViewController else { return }
        contactInfoVC.contact = sender as? Person
    }
}

// MARK: - SearchController
extension ContactListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else { return }
        let text = searchText.trimmingCharacters(in: .whitespaces)
        
        filteredContacts = []
        if text == "" {
            filteredContacts = contacts.sorted(by: { $0.name < $1.name })
        }
        
        for contact in contacts {
            if contact.fullName.contains(text) {
                filteredContacts.append(contact)
            }
        }
        
        filteredContacts = filteredContacts.sorted(by: { $0.name < $1.name })
        tableView.reloadData()
    }
    
    
}

// MARK: - TableView Extensions
extension ContactListViewController {
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let contact = filteredContacts[indexPath.row]
        performSegue(withIdentifier: "showInfo", sender: contact)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        62
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredContacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Contact
        let contact = filteredContacts[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        // Image
        content.image = UIImage(named: contact.sex.rawValue)
        // in case we get square image from user (will be possible in future)
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        
        // Text
        content.text = contact.fullName
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 18)
        content.textProperties.color = .white
        
        // Secondary text
        let randomTime = Int.random(in: 0...59) // further customization needed
        if randomTime == 0 {
            content.secondaryText = "last seen recently"
        } else {
            content.secondaryText = "last seen \(randomTime) minutes ago"
        }
        
        content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 14)
        content.secondaryTextProperties.color = .systemGray
        
        cell.contentConfiguration = content
        
        // background color when selected
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor(red: 0.983, green: 0.891, blue: 0.600, alpha: 1)
        cell.selectedBackgroundView = selectedView
        selectedView.sizeToFit()
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
