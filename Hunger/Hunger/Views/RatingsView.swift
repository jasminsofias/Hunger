//
//  RatingsView.swift
//  Hunger
//
//  Created by Sofia Abd Alwaheb on 2022-12-19.
//

import SwiftUI


struct RatingsView: View {
    
    @StateObject var hungerVM = HungerVM()
    //@State var showBadge: Bool = false
    
    var landmar: String
    
    var body: some View {
        ZStack{
            NavigationView{
                Form{
                    
                    Section {
                        TextEditor(text: $hungerVM.review)
                        StarRateView(rating: $hungerVM.rating)
                    } header: {
                        Text("Write a review")
                    }
                    
                    
                    
                    Button("Add rating"){
                        hungerVM.addRatingButtonPressed(landmark: landmar)
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(width: 350, height: 80)
                    .background(Color("hunger"))
                    .cornerRadius(10)
                
                    
                    Section{
                        List{
                            
                            ForEach(hungerVM.ratings, id: \.self){
                                if(landmar == $0.landmark){
                                    StarView(rating: $0.rating)
                                    
                                }
                                
                            }
                            
                            
                        }
                        .listStyle(PlainListStyle())
                        .frame(width: 350, height: 80)
                    } header:{
                        Text("Ratings on this restaurant")
                    }
                    
                    Section{
                        List{
                            
                            ForEach(hungerVM.ratings, id: \.self){
                                
                                if(landmar == $0.landmark){
                                    
                                    Text("\($0.review)                                 \($0.name)")
                                    
                                    
                                }
                                
                                
                            }
                            
                            
                        }
                        .listStyle(PlainListStyle())
                        .frame(width: 350, height: 80)
                    } header:{
                        Text("Comments on this restaurant")
                    }
                }
            }
        }
    }
}

struct RatingsView_Previews: PreviewProvider {
    static var previews: some View {
        RatingsView( landmar: "")
    }
}
