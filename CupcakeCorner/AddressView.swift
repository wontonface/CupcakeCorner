//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Nicole on 1/27/25.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    @State private var showingSaveConfirmation = false
    
    func saveAddress() {
        let newAddress = DeliveryAddress(
            personName: order.name,
            addressName: order.streetAddress,
            cityName: order.city,
            zipCode: order.zip
        )
        order.savedAddresses.append(newAddress)
        showingSaveConfirmation = true
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
                Button("Save my address for next time") {
                    saveAddress()
                }
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Address saved", isPresented: $showingSaveConfirmation) {
            Button("OK") {  }
        } message: {
            Text("Your address has been saved for future orders.")
        }
    }
}

#Preview {
    AddressView(order: Order())
}
