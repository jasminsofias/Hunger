//
//  MapView.swift
//  Hunger
//
//  Created by Sofia Abd Alwaheb on 2022-12-15.
//

import SwiftUI
import CoreLocation
import MapKit

struct StartView: View {
    
    @EnvironmentObject var localSearchService: LocalSearchService
    @State private var search: String = "Restaurants"
    @StateObject var hungerVM =  HungerVM()

    var body: some View {
        
        VStack{
          
                Spacer().frame(height: 40)
                TextField("Search", text: $search)
                    .textFieldStyle(.roundedBorder)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 2))
                    .onSubmit{
                        localSearchService.search(query: search)
                        
                    }.padding()
                if localSearchService.landmarks.isEmpty{
                    Button("Just Hunger it!"){
                        localSearchService.search(query: search)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(.gray, lineWidth: 2))
                    .foregroundColor(.black)
                    .background(Color("hunger"))
                    .cornerRadius(15)
                    
                }else{
                    LandmarkListView()
                        .environmentObject(HungerVM())
                }
            
            ZStack(alignment: .topLeading){
                Map(coordinateRegion: $localSearchService.region, showsUserLocation: true, annotationItems: localSearchService.landmarks){
                    landmark in
                    MapAnnotation(coordinate: landmark.coordinate) {
                        Image(systemName: "h.square.fill")
                            .foregroundStyle(.black, Color("hunger"))
                            .scaleEffect(localSearchService.landmark == landmark ? 2: 1)
                    }
                }
                HStack{
                    Button("🎖"){
                        hungerVM.checkRating()
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 2))
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    //.frame(width: 60, height: 60)
                    .background(Color("hunger"))
                    .cornerRadius(10)
                    .sheet(isPresented: $hungerVM.showBadge, content: {
                        
                        BadgeView(badge: hungerVM.badge, description: hungerVM.description)
                    })
                    
                    Spacer()
                    Button{
                        hungerVM.checkFriends()
                    } label: {
                        Image(systemName: "person.fill.badge.plus")
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 2))
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    //.frame(width: 60, height: 60)
                    .background(Color("hunger"))
                    .cornerRadius(10)
                    .sheet(isPresented: $hungerVM.showFriends, content: {
                        AddFriendView()
                    })
                }
            }
            
        }
    }
    
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
      
        StartView().environmentObject(LocalSearchService())
            .environmentObject(HungerVM())
    }
}
