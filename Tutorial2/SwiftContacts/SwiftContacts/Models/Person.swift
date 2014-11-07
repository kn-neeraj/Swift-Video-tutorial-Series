//
//  Person.swift
//  SwiftContacts
//
//  Created by Neeraj Kumar on 05/11/14.
//  Copyright (c) 2014 Neeraj Kumar. All rights reserved.
//

import UIKit

// MARK: Name
struct Name {
    var firstName: String
    var middleName: String? // Optional because not everybody has a middle name.
    var lastName: String
    
    init() {
        self.firstName = ""
        self.lastName = ""
    }
    
    init(firstName:String, middleName:String, lastName:String) {
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
    }
}

extension Name {
    // Computed property.
    var finalName:String {
        if let uwMiddleName = self.middleName {
            if uwMiddleName != "" {
               return  "\(self.firstName) \(uwMiddleName) \(self.lastName)"
            }
        }
        return "\(self.firstName) \(self.lastName)"
    }
}

// MARK: Input validity.
extension Name:Validity {
    func isValid() -> Bool {
        if self.firstName != "" && self.lastName != "" {
            return true
        }
        return false
    }
}


// MARK: Address
struct Address {
    var flatNo: String
    var locality: String
    var city: String
    // TODO: Add state, country - Homework and other logical places.
    var pindcode: String
    var landmark: String? // Optional
    
    init() {
       self.flatNo = ""
       self.locality = ""
       self.city = ""
       self.pindcode = ""
    }
    
    init(flatNo:String, locality:String, city:String, pindCode:String, landMark: String) {
        self.flatNo = flatNo
        self.locality = locality
        self.city = city
        self.pindcode = pindCode
        self.landmark = landMark
    }
}

extension Address {
    var description:String {
        if let uwLandmark = landmark {
            if uwLandmark != "" {
                return "\(self.flatNo), \(self.locality) \n \(self.city) , \(self.pindcode) \n \(uwLandmark)"
            }
        }
        return "\(self.flatNo), \(self.locality) \n \(self.city) , \(self.pindcode)"
    }
}

extension Address:Validity {
    func isValid() -> Bool {
        if self.flatNo != "" && self.locality != "" && self.city != "" && self.pindcode != "" {
            return true
        }
        return false
    }
}

// MARK: PhoneNumber
struct PhoneNumber {
    var diallingCode: String
    var phoneNumber: String
    
    init() {
        self.diallingCode = ""
        self.phoneNumber = ""
    }
    
    init(diallingCode:String, phoneNumber:String) {
        self.diallingCode = diallingCode
        self.phoneNumber = phoneNumber
    }

}

extension PhoneNumber {
    var description:String {
        return "+\(self.diallingCode) \(self.phoneNumber)"
    }
}

extension PhoneNumber:Validity {
    func isValid() -> Bool {
        if self.diallingCode != "" && self.phoneNumber != "" {
            return true
        }
        return false
    }
}


// MARK: Person class
class Person: NSObject {
    var name: Name
    var address: Address
    var phoneNumber: PhoneNumber
    
    init(name:Name, address:Address, phoneNumber:PhoneNumber) {
        self.name = name
        self.address = address
        self.phoneNumber = phoneNumber
        super.init()
    }
}

extension Person:Validity {
    func isValid() -> Bool {
        if self.name.isValid() && self.address.isValid() && self.phoneNumber.isValid() {
            return true
        }
        return false
    }
}

