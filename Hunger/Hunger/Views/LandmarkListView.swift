//
//  LandmarkListView.swift
//  Hunger
//
//  Created by Sofia Abd Alwaheb on 2022-12-15.
//

import SwiftUI
import MapKit

struct LandmarkListView: View {
    
    @StateObject var hungerVM =  HungerVM()
    @EnvironmentObject var localSearchService: LocalSearchService
    
    var body: some View {
        VStack{
            List(localSearchService.landmarks){
                landmark in
                NavigationLink(destination: RatingsView(landmar: landmark.name)){
                    HStack{
                        VStack(alignment: .leading){
                            Text(landmark.name)
                                .foregroundColor(.gray)
                            Text(landmark.title)
                                .opacity(0.5)
                                .foregroundColor(.gray)
                            
                        }
                        
                        
                        
                        /* Text("NAME: \(hungerVM.userName)")
                         .foregroundColor(.black)*/
                    }
                    .listRowBackground(localSearchService.landmark == landmark ? Color(UIColor.lightGray): Color.white)
                    .onTapGesture {
                        localSearchService.landmark = landmark
                        withAnimation{
                            localSearchService.region = MKCoordinateRegion.regionFromLandmark(landmark)
                        }
                    }
                }
            }
        }
    }
}

struct LandmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkListView().environmentObject(LocalSearchService())

    }
}
