//
//  Order.swift
//  CupcakeCorner
//
//  Created by Nicole on 1/27/25.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    // MARK: - Cupcake customization
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    // MARK: - Delivery info
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var savedAddresses: [DeliveryAddress] = [] {
        didSet {
            saveAddresses()
        }
    }
    
    // MARK: - Validation
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    // MARK: - Pricing logic
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1 per cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.50 per cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    // MARK: - UserDefaults methods
    
    private static func loadAddresses() -> [DeliveryAddress] {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.addresses) else {
            return []
        }
        
        do {
            let decoded = try JSONDecoder().decode([DeliveryAddress].self, from: data)
            print("Successfully loaded \(decoded.count) addresses:")
            decoded.forEach { address in
                print("- \(address.personName): \(address.addressName), \(address.cityName), \(address.zipCode)")
            }
            return decoded
        } catch {
            print("Error loading addresses: \(error.localizedDescription)")
            return []
        }
    }
    
    private func saveAddresses() {
        print("Saving \(savedAddresses.count) addresses to UserDefaults:")
        savedAddresses.forEach { address in
            print("- \(address.personName): \(address.addressName), \(address.cityName), \(address.zipCode)")
        }
        
        do {
            let encoded = try JSONEncoder().encode(savedAddresses)
            UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.addresses)
            print("Successfully saved addresses to UserDefaults")
  
        } catch {
            print("Error saving addresses: \(error.localizedDescription)")
        }
    }
    
    
    
}


