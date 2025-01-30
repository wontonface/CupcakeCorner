//
//  DeliveryAddress.swift
//  CupcakeCorner
//
//  Created by Nicole on 1/29/25.
//

import Foundation

struct DeliveryAddress: Identifiable, Codable {
    let id = UUID()
    var personName: String
    var addressName: String
    var cityName: String
    var zipCode: String
}
