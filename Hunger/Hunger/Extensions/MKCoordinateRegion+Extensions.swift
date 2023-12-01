//
//  MKCoordinateRegion+Extensions.swift
//  Hunger
//
//  Created by Sofia Abd Alwaheb on 2022-12-15.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    
    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.22194, longitude: 17.93819), span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
    }
    
    static func regionFromLandmark(_ landmark: Landmark) -> MKCoordinateRegion {
        MKCoordinateRegion(center: landmark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    }
    
}
