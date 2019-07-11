//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Zomato on 11/07/19.
//  Copyright © 2019 Zomato. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let reuseID: String = "mycell"
    var arrayOfUsers: [User] = []
    var image: Data = Data()
    let tableView = UITableView(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.backgroundColor = .red
//        createViews()
        let user = Users()
        user.getData(urlString: "https://jsonplaceholder.typicode.com/users") { (users) in
            self.arrayOfUsers = users
            // To execute reloaddata in UI thread and not background thread
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
        user.getImage(urlString: "https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/epic-summer-salad.jpg") {(data) in
            self.image = data
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
        createList()
    }
    
    func createList() {
        view.addSubview(tableView)
        tableView.set(.fillSuperView(view))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: reuseID)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        switch indexPath.section {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! MyTableViewCell
//            cell.setData(restaurant: arrayOfRes[indexPath.row])
//            return cell
//        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! MyTableViewCell2
//            cell.setData(restaurant: arrayOfRes[indexPath.row])
//            return cell
//        default:
//            return UITableViewCell(style: .default, reuseIdentifier: "empty")
//        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! MyTableViewCell
        cell.setData(user: arrayOfUsers[indexPath.row], image: image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(arrayOfUsers[indexPath.row].name)
    }
    
    
    func createViews() {
        let redView = UIView()
        redView.backgroundColor = .red
        view.addSubview(redView)
        // redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
        redView.set(.top(view, 50),
                    .sameLeadingTrailing(view, 12),
                    .height(200))
        
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        view.addSubview(yellowView)
        yellowView.set(.below(redView, 12),
                       .leading(view, 12),
                       .width(30),
                       .height(100))
        
        let greenView = UIView()
        greenView.backgroundColor = .green
        view.addSubview(greenView)
        greenView.set(.after(yellowView, 12),
                      .top(yellowView),
                      .trailing(view, 12),
                      .height(100))
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        view.addSubview(blueView)
        blueView.set(.trailing(view, 12),
                     .below(greenView, 12),
                     .height(100),
                     .width(30))
        
        let orangeView = UIView()
        orangeView.backgroundColor = .orange
        view.addSubview(orangeView)
        orangeView.set(.before(blueView, 12),
                       .height(100),
                       .top(blueView),
                       .leading(yellowView))
    }


}

