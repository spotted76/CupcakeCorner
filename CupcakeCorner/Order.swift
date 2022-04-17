//
//  Order.swift
//  CupcakeCorner
//
//  Created by Peter Fischer on 4/16/22.
//

import Foundation

struct Order: Codable {
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        
        if validateString(name) && validateString(streetAddress) && validateString(city) && validateString(zip){
            return true
        }
        
        return false
    }
    
    // Calculate the total cost
    var cost : Double {
        
        //$2 per cake
        var cost = Double(quantity) * 2.0
        
        // Complicated cakes cost more
        cost += (Double(type) / 2.0)
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
//
//
//    }
    
//    required init(from decoder: Decoder) throws {
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
//
//
//    }
    
    init() { }
    
    // Returns true if the string is valid
    func validateString(_ candidate:String) -> Bool {
        let temp = candidate.trimmingCharacters(in: .whitespacesAndNewlines)
        return temp.isEmpty != true
    }
}

class OrderContainer : ObservableObject {
    @Published var order: Order
    
    init() {
        order = Order()
    }
}
