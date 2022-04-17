//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Peter Fischer on 4/16/22.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var oc: OrderContainer
    
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $oc.order.name)
                TextField("Street Address", text: $oc.order.streetAddress)
                TextField("City", text: $oc.order.city)
                TextField("Zip", text: $oc.order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(oc: oc)
                } label: {
                    Text("Check Out")
                }
            }
            .disabled(!oc.order.hasValidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(oc: OrderContainer())
    }
}
