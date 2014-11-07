//
//  Protocols.swift
//  SwiftContacts
//
//  Created by Neeraj Kumar on 06/11/14.
//  Copyright (c) 2014 Neeraj Kumar. All rights reserved.
//

import Foundation

// Input validity. This method definition should define if the current entered value is valid or not.
protocol Validity {
        func isValid() -> Bool
}