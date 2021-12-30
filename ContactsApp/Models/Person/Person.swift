//
//  ContactModel.swift
//  ContactsApp
//
//  Created by Snow Lukin on 27.12.2021.
//

import Foundation
import UIKit

class Person {
    
    enum Sex: String {
        case male = "defaultUserMale"
        case female = "defaultUserFemale"
    }
    
    var name: String
    var surname: String
    var email: String
    var phoneNumber: String
    var sex: Sex
    
    var fullName: String {
        name + " " + surname
    }
    
    init( name: String, surname: String?, email: String?, phoneNumber: String?, sex: Sex?) {
        self.name = name
        self.surname = surname ?? ""
        self.email = email ?? ""
        self.phoneNumber = phoneNumber ?? ""
        self.sex = sex ?? .male
    }
    
    
    static func getPersonsInfo() -> [Person] {
        
        var persons = [Person]()
        
        var names = DataManager.shared.names.shuffled()
        var surnames = DataManager.shared.surnames.shuffled()
        var emails = DataManager.shared.emails.shuffled()
        var phoneNumbers = DataManager.shared.phones.shuffled()
        let sexes: [Sex] = [.male, .female]
        
        for _ in 1...DataManager.shared.names.count {
            persons.append(
                Person(name: names.popLast() ?? "Not Found",
                       surname: surnames.popLast(),
                       email: emails.popLast(),
                       phoneNumber: phoneNumbers.popLast(),
                       sex: sexes.randomElement()!)
            )
        }
        
        return persons
    }
}
