//
//  RestaurantModel.swift
//  MyFirstApp
//
//  Created by Zomato on 11/07/19.
//  Copyright © 2019 Zomato. All rights reserved.
//

import UIKit

struct User {
    var name: String?
    var email: String?
    
    init(name: String, email: String) {
        self.email = email
        self.name = name
    }
    
    init() {
        
    }
    
    func getUserWithObject(object : [String: Any]) -> User {
        var user = User()
        if let name = object["name"] as? String {
            user.name = name
        }
        if let email = object["email"] as? String {
            user.email = email
        }
        return user
    }
}

class Users: NSObject {
    var usersArray: [User]?
    
    override init() {
        super.init()
    }
    
    func getData(urlString: String, completionHanlder: @escaping ([User]) -> ()) {
        var users: [User] = []
        if let url = URL(string: urlString) {
            let datatask = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else {return}
                let jsonData = self.convertToDictionary(data: data)
                guard let parsedJSONData = jsonData else {return}
                
                for object in parsedJSONData{
                    var user = User()
                    user = user.getUserWithObject(object: object)
                    users.append(user)
                }
                completionHanlder(users)
//                self.usersArray = users
            }
            datatask.resume()
        }
    }
    
    func getImage(urlString: String, completionHandler: @escaping (Data) -> ()) {
        var image: Data = Data()
        if let url = URL(string: urlString) {
            let imageTask = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else {return}
                image = data
                completionHandler(image)
            }
            imageTask.resume()
        }
    }
    
    
    // Returns a dictionary of key String and Any values
    func convertToDictionary(data: Data?) -> [[String: Any]]? {
        guard let data = data else { return nil }
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
