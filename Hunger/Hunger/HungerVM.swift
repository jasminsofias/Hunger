//
//  HungerVM.swift
//  Hunger
//
//  Created by Sofia Abd Alwaheb on 2022-12-19.
//

import Foundation
import SwiftUI
import CloudKit

class HungerVM: ObservableObject{
    
    @Published var isSignedIn: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    @Published var userLast: String = ""
    @Published var userID: String = ""
    @Published var permissionStatus: Bool = false
    
    @Published var rating: Int =  0
    @Published var review: String = ""
    @Published var ratings: [Rating] = []
    @Published var users: [Person] = []
    @Published var landmark: String = ""
    @Published var comments: [String] = []
    
    @Published var showBadge: Bool = false
    @Published var badge: Badge = Badge.level1
    @Published var description: String = ""
    
    @Published var friendEmail: String = ""
    @Published var friends: [String] = []
    @Published var showFriends: Bool = false
    
    init(){
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordID()
        fetchRatings()
        fetchUsers()
        checkRating()
    }
    
    private func getiCloudStatus(){
        CKContainer.default().accountStatus { [weak self] returnStatus, returnError in
            DispatchQueue.main.async {
                switch returnStatus{
                case .available:
                    self?.isSignedIn = true
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.localizedDescription
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.localizedDescription
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.localizedDescription
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.localizedDescription
                }
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError{
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
    
    func requestPermission(){
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted{
                    self?.permissionStatus = true
                }
            }
        }
    }
    
    func fetchiCloudUserRecordID(){
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID{
                self?.discoverICloudUser(id: id)
            }
        }
    }

    
    func discoverICloudUser(id: CKRecord.ID){
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
            DispatchQueue.main.async{
                if let name = returnedIdentity?.nameComponents?.givenName{
                    self?.userName = name
                    
                }
                
                if let last = returnedIdentity?.nameComponents?.familyName{
                    self?.userLast = last
                }
                
                if let identity = returnedIdentity?.userRecordID?.description{
                    self?.userID = identity
                }
            }
        }
    }
    
    func addFriendButtonPressed(){
        guard !friendEmail.description.isEmpty else{return}
        addFriend()
    }
    
    
    func addRatingButtonPressed(landmark: String){
        guard !rating.description.isEmpty else{ return }
        findUser()
        addRating(rate: rating, revie: review, restaurant: landmark, name: userName, id: userID)
    }
    
    func addFriend(){
        for user in users{
            if user.firstname == userName{
                updateFriendList(person: user)
            }
        }
    }
    
    func findUser(){
        for user in users{
            if user.firstname == userName{
                updatePerson(person: user)
            }
        }
    }
    
    func checkFriends(){
       showFriends = true
    }
    
    func checkRating(){
        for user in users{
            if user.firstname == userName{
                if user.ratingCount >= 0{
                    switch user.ratingCount{
                    case 0:
                        badge = Badge.level1
                        description =  "WELCOME!\n\nYou're a newly laid fragile egg, to hatch you have to rate more restaurants!\n\nWonder what you will evolve to next time?👀"
                        showBadge = true
                    case 1:
                        badge = Badge.level1
                        description =  "WELCOME!\n\nYou're a newly laid fragile egg, to hatch you have to rate more restaurants!\n\nWonder what you will evolve to next time?👀"
                        showBadge = true
                    case 2:
                        badge = Badge.level2
                        print(badge.rawValue)
                        description =  "CONGRATULATIONS!\n\nYou're a newly hatched chicken, opening your eyes for the first time to explore the world!\nRate more places to evolve.\n\nWonder what you will evolve to next time?👀"
                        showBadge = true
                    case 3:
                        badge = Badge.level3
                        description =  "CONGRATULATIONS!\n\nYou're a baby chicken.\nCurious and exploring restaurants, put in more ratings to evolve and become a real foodie!\n\nWonder what you will evolve to next time?👀"
                        showBadge = true
                    case 4:
                        badge = Badge.level4
                        description =  "CONGRATULATIONS!\n\nYou're a fully grown rooster!\nWhat a stylish wattle, edgy mohawk and scrumptious cock-a-doodle-doo you have.\nAt this point you can definitely call yourself a foodie.\n\nWonder what you will evolve to next time?👀"
                        showBadge = true
                    case 5:
                        badge = Badge.level5
                        description =  "CONGRATULATIONS!\n\nWow! You're now a stunning peacock😍 The shine of your feathers, the portliness of your existence and the elegance of your squawk is breathtaking. What a superfoodie you've become!\n\nYou're now a top tier foodie🏆"
                        showBadge = true
                    case 6:
                        showBadge = true
                        description =  "CONGRATULATIONS!\n\nWow! You're now a stunning peacock😍 The shine of your feathers, the portliness of your existence and the elegance of your squawk is breathtaking. What a superfoodie you've become!\n\nYou're now a top tier foodie🏆"
                    default:
                        showBadge = true
                        description =  "CONGRATULATIONS!\n\nWow! You're now a stunning peacock😍 The shine of your feathers, the portliness of your existence and the elegance of your squawk is breathtaking. What a superfoodie you've become!\n\nYou're now a top tier foodie🏆"
                    }
                }
            }
        }
    }
    
    private func addRating(rate: Int, revie: String, restaurant: String, name: String, id: String){
       
        let newRating = CKRecord(recordType: "Rating")
       
        newRating["rate"] = rate
        newRating["review"] = revie
        newRating["restaurant"] = restaurant
        newRating["name"] = name
        newRating["userID"] = id
        
        save(record: newRating)
    }
    
    private func addPerson(user: Person){
        
        let newPerson = user.record//CKRecord(recordType: "Person")
        
        newPerson["email"] = user.email
        newPerson["firstname"] = user.firstname
        newPerson["lastname"] = user.lastname
        newPerson["ratingCount"] = user.ratingCount
        newPerson["userID"] = user.userID
        newPerson["friends"] = user.friends
        
        save(record: newPerson)
    }
    
    func createUser(email: String, firstname: String, lastname: String, userID: String, friendsList: Array<String>){
        guard !userName.description.isEmpty else { return }
        addPerson(user: Person(email: email, firstname: firstname, lastname: lastname, ratingCount: 0, record: CKRecord(recordType: "Person"), userID: userID, friends: friendsList))
    }
    
    private func save(record: CKRecord){
        CKContainer.default().publicCloudDatabase.save(record) { returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
            self.fetchRatings()
            self.review = ""
            self.friendEmail = ""
            self.fetchUsers()
            
        }
    }
    
    func fetchRatings(){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Rating", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedRatings: [Rating] = []
        
        if #available(iOS 16.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    guard let rate = record["rate"] as? Int else{ return }
                    guard let revie = record["review"] as? String else{ return }
                    guard let restaurant = record["restaurant"] as? String else{ return }
                    guard let name = record["name"] as? String else{ return }
                    guard let id = record["userID"] as? String else{ return }


                    returnedRatings.append(Rating(name: name, rating: rate, review: revie, landmark: restaurant, userID: id))
                case .failure(let error):
                    print("ERROR: \(error)")
                }
                
            }
        }else{
            queryOperation.recordFetchedBlock = { (returnedRecord) in
                guard let rate = returnedRecord["rate"] as? Int else{ return }
                guard let revie = returnedRecord["revie"] as? String else{ return }
                guard let restaurant = returnedRecord["restaurant"] as? String else{ return }
                guard let name = returnedRecord["name"] as? String else{ return }
                guard let id = returnedRecord["userID"] as? String else{ return }


                returnedRatings.append(Rating(name: name, rating: rate, review: revie, landmark: restaurant, userID: id))
               
            }
        }
        
        if #available(iOS 16.0, *){
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                print("RETURNED RESULT: \(returnedResult)")
                DispatchQueue.main.async {
                    self?.ratings = returnedRatings

                }
            }
        }else{
            queryOperation.queryCompletionBlock = { [weak self](returnedCursor, returnedError) in
                print("RETURNED QueryCompletionBlock")
                DispatchQueue.main.async {
                    self?.ratings = returnedRatings

                }

            }
        }
        addOperation(operation: queryOperation)
    }
    
    func fetchUsers(){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Person", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedUsers: [Person] = []
        
        if #available(iOS 16.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    guard let email = record["email"] as? String else{ return }
                    guard let firstname = record["firstname"] as? String else{ return }
                    guard let lastname = record["lastname"] as? String else{ return }
                    guard let ratingCount = record["ratingCount"] as? Int else{ return }
                    guard let id = record["userID"] as? String else{ return }
                    guard let friendsList = record["friends"] as? [String] else {return}


                    returnedUsers.append(Person(email: email, firstname: firstname, lastname: lastname, ratingCount: ratingCount, record: record, userID: id, friends: friendsList))
                case .failure(let error):
                    print("ERROR: \(error)")
                }
                
            }
        }else{
            queryOperation.recordFetchedBlock = { (returnedRecord) in
                guard let email = returnedRecord["email"] as? String else{ return }
                guard let firstname = returnedRecord["firstname"] as? String else{ return }
                guard let lastname = returnedRecord["lastname"] as? String else{ return }
                guard let ratingCount = returnedRecord["ratingCount"] as? Int else{ return }
                guard let id = returnedRecord["userID"] as? String else{ return }
                guard let friendsList = returnedRecord["friends"] as? [String] else {return}

                returnedUsers.append(Person(email: email, firstname: firstname, lastname: lastname, ratingCount: ratingCount, record: returnedRecord, userID: id, friends: friendsList))
            }
        }
        
        if #available(iOS 16.0, *){
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                print("RETURNED RESULT: \(returnedResult)")
                DispatchQueue.main.async {
                    self?.users = returnedUsers
                    self?.friends = returnedUsers.first!.friends
                }
                
            }
        }else{
            queryOperation.queryCompletionBlock = { [weak self](returnedCursor, returnedError) in
                print("RETURNED QueryCompletionBlock")
                DispatchQueue.main.async {
                    self?.users = returnedUsers
                    self?.friends = returnedUsers.first!.friends

                }

            }
        }
        addOperation(operation: queryOperation)
    }
    
    
    func addOperation(operation: CKDatabaseOperation){
        CKContainer.default().publicCloudDatabase.add(operation)

    }
    
    func updatePerson(person: Person){
        let record = person.record
        let count = (person.ratingCount + 1)
        record["ratingCount"] = count
        save(record: record)
    }
    
    func updateFriendList(person: Person){
        let record = person.record
        var friendsList: [String] = []
        friendsList.append(friendEmail)
        record["friends"] = friendsList
        save(record: record)
    }
    
}
