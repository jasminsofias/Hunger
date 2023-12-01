//
//  FriendAddedView.swift
//  Hunger
//
//  Created by Sofia Abd Alwaheb on 2023-01-09.
//

import SwiftUI

struct FriendAddedView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Color("hunger-blue").edgesIgnoringSafeArea(.all)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 200){
                ZStack(alignment: .topLeading){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding(20)
                    })
                }
                VStack(alignment: .center, spacing: 30){
                    Image("friend-added")
                        .resizable()
                        .scaledToFit()
                    Text("🤝")
                        .font(.system(size: 200, weight: .bold, design: .rounded))
                        
                }
            }

        }
    }
}

struct FriendAddedView_Previews: PreviewProvider {
    static var previews: some View {
        FriendAddedView()
    }
}
