//
//  SignInView.swift
//  Hunger
//
//  Created by Sofia Abd Alwaheb on 2022-12-14.
//
import AuthenticationServices
import SwiftUI

struct SignInView: View {
    let gradient = LinearGradient(colors: [Color.red,Color.gray],
                                      startPoint: .top, endPoint: .bottom)
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userID") var userID: String = ""
    @StateObject var hungerVM = HungerVM()
    @State var showSign: Bool = false
   // @Published var user = firstName: String
    
    
    var body: some View {
        NavigationView{
            
            VStack{
                if(showSign == true){
                    Image("hunger-image")
                        .resizable()
                        .scaledToFit()
                }
                if userID.isEmpty{
                    SignInWithAppleButton(.continue){
                        request in
                        request.requestedScopes = [.email, .fullName]
                        
                    } onCompletion: { result in
                        switch result{
                        case .success(let auth):
                            switch auth.credential{
                            case let credential as ASAuthorizationAppleIDCredential :
                                
                                let email = credential.email?.description
                                let firstName = credential.fullName?.givenName
                                let lastName = credential.fullName?.familyName
                                let userID = credential.user
                                
                                hungerVM.createUser(email: email ?? "", firstname: hungerVM.userName, lastname: hungerVM.userLast, userID: hungerVM.userID, friendsList: hungerVM.friends)
                                
                                self.email = email ?? ""
                                self.firstName = firstName ?? ""
                                self.lastName = lastName ?? ""
                                self.userID = userID
                                showSign = false
                                
                                
                            default:
                                break
                            }
                        case .failure(let error):
                            print(error)
                            
                        }
                        
                    }
                    .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                    .frame(height: 50)
                    .padding()
                    .cornerRadius(8)
                    
                    
                }
                else{
                    
                    StartView()
                        .environmentObject(HungerVM())
                        .ignoresSafeArea()
            
                }
                
            }
           
            
        }
        
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
