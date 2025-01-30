//
//  AddressStorage.swift
//  CupcakeCorner
//
//  Created by Nicole on 1/29/25.
//

import SwiftUI

// We make this an enum for code maintenance purposes. With this, if we ever need to change the key name, we just change it here.
// Similar to a singleton, in how we use UserDefaults.standard or ClassName.shared instead of creating new instances.
// This way, we have one source of truth.

enum UserDefaultsKeys {
    static let addresses = "savedAddresses"
}
