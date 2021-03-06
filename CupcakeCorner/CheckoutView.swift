//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Peter Fischer on 4/16/22.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var oc: OrderContainer
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var errorMessage = ""
    @State private var alertOnFailure = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(oc.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    print("This button should be called")
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        }message: {
            Text(confirmationMessage)
        }
        .alert("Failure", isPresented: $alertOnFailure) {
            Button("OK") { }
        }message: {
            Text(errorMessage)
        }
    }
    
    func placeOrder() async {
                
        guard let encoded = try? JSONEncoder().encode(oc.order) else {
            print("Faied to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
                        
            //Decode the data
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            
            showingConfirmation.toggle()
            
        } catch {
            print("Checkout failed")
            errorMessage = "Failed occurred submitting order"
            alertOnFailure.toggle()
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(oc: OrderContainer())
    }
}
