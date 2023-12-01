/////  HungerModel.swift
//  Hunger
//
//  Created by Sofia Abd Alwaheb on 2022-12-14.
//

import Foundation
import MapKit
import CloudKit

struct Person: Hashable{
    var email: String
    var firstname: String
    var lastname: String
    var ratingCount: Int
    var record: CKRecord
    var userID: String
    var friends: [String]
}

struct Rating: Hashable{
    var name: String
    var rating: Int
    var review: String
    var landmark: String
    var userID: String
}

enum Badge: String{
    case level1 = "🥚"
    case level2 = "🐣"
    case level3 = "🐥"
    case level4 = "🐓"
    case level5 = "🦚"
}


