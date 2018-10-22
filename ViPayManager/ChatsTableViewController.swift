//
//  ChatsTableViewController.swift
//  ViPayManager
//
//  Created by Rock on 2018/10/7.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import Parse

class ChatsTableViewController: UITableViewController {
    
    fileprivate let identifier = "identifier"
    fileprivate var Rooms = [PFUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ChatsTableViewCell.self, forCellReuseIdentifier: identifier)
        navigationItem.title = "Business Chats"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        navigationController?.navigationBar.tintColor = defaultAppColor
        self.loadChatRooms()
    }
    
    func loadChatRooms(){
        let user = PFUser.current()!
        print(user.objectId)
        let pred = NSPredicate(format: "userOne = %@ OR userTwo = %@", user,user)
        let query = PFQuery(className: "BizRoom", predicate: pred)
        query.includeKeys(["userOne","userTwo"])
        query.cachePolicy = PFCachePolicy.cacheThenNetwork
        query.findObjectsInBackground { (results, error) in
            if error == nil {
                if (results?.count)! > 0 {
                    self.Rooms.removeAll(keepingCapacity: true)
                    for room in results! {
                        if let userOne = room.object(forKey: "userOne") as? PFUser {
                            if userOne.objectId != user.objectId{
                                self.Rooms.append(userOne)
                            }
                        }
                        if let userTwo = room.object(forKey: "userTwo") as? PFUser {
                            if userTwo.objectId != user.objectId{
                                self.Rooms.append(userTwo)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Rooms.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ChatsTableViewCell
        cell.profileRingImageView.isHidden = true
        let user = self.Rooms[indexPath.row]
        if let displayName = user.object(forKey: "displayName") as? String {
            cell.usernameLabel.text = displayName
            if let profileImageFile = user.object(forKey: "profileImageFile") as? PFFile {
                let url = URL(string: profileImageFile.url!)
                cell.profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = self.Rooms[indexPath.row]
        let sellersLogsVC = BusinessChatTableViewController()
        sellersLogsVC.incomingUser = selectedUser
        sellersLogsVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(sellersLogsVC, animated: true)
    }

}
