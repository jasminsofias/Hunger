//
//  AddFriendView.swift
//  Hunger
//
//  Created by Sofia Abd Alwaheb on 2023-01-05.
//

import SwiftUI

struct AddFriendView: View {
    
    @StateObject var hungerVM = HungerVM()
    @State var showFriendAdded: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView{
            ZStack(alignment: .topLeading){
               
                VStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .padding(20)
                    })
                    Form{
                    
                    //VStack{
                    Section {
                        TextEditor(text: $hungerVM.friendEmail)
                    } header: {
                        Text("Add friends to share the experience.\nUse your friends apple-ID email to connect")
                        //Text("Use your friends apple-ID email to connect")
                    }
                    ZStack{
                        Button("Add friend"){
                            hungerVM.addFriendButtonPressed()
                            showFriendAdded.toggle()
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 350, height: 80)
                        .background(Color("hunger"))
                        .cornerRadius(10)
                        .sheet(isPresented: $showFriendAdded, content:{
                            FriendAddedView()
                        } )
                        
                    }
                }
                }
            }
        }
    }
}



struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendView()
    }
}
