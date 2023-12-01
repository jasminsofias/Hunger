//
//  Landmark.swift
//  Hunger
//
//  Created by Sofia Abd Alwaheb on 2022-12-15.
//

import Foundation
import SwiftUI
import MapKit

struct Landmark: Identifiable, Hashable {
    
    let placemark: MKPlacemark
    
    let id = UUID()
    
    var name: String {
        self.placemark.name ?? ""
    }
    
    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
}
