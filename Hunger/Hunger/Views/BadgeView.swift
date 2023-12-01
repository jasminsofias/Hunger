//
//  BadgeView.swift
//  Hunger
//
//  Created by Sofia Abd Alwaheb on 2023-01-04.
//

import SwiftUI

struct BadgeView: View {
    
    @StateObject var hungerVM = HungerVM()
    @State private var useLargeTitle = false
    @Environment(\.presentationMode) var presentationMode
    var badge: Badge
    var description: String
    
    var body: some View{
        ZStack(alignment: .topLeading){
            Color("hunger-blue").edgesIgnoringSafeArea(.all) //frame(width: 200, height: 100)
            
            VStack(spacing: 30){
                ZStack(alignment: .topLeading){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        //EnvironmentValues.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .padding(20)
                    })
                }
                VStack(alignment: .center, spacing: 30){
                    Image("your-rank")
                        .resizable()
                        .scaledToFit()
                    VStack(spacing: 30){
                        Text(badge.rawValue)
                            .font(useLargeTitle ? .system(size: 150) : .body)
                        
                        Text(description)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(Color("hunger"))
                        //.textCase(.uppercase)
                            .multilineTextAlignment(.center)
                            .padding(1.0)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    }
                }
                .onAppear{
                    withAnimation{
                        useLargeTitle.toggle()
                    }
                }
            }
        }
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView(badge: Badge.level1, description: "HEEEY HOOO LETS GOO")
    }
}
