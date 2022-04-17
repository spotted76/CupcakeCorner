//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Peter Fischer on 4/15/22.
//

import SwiftUI



struct ContentView: View {

    @StateObject var oc = OrderContainer()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $oc.order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(oc.order.quantity)", value: $oc.order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any Special Requests?", isOn: $oc.order.specialRequestEnabled.animation())
                    
                    if oc.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $oc.order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $oc.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(oc: oc)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
