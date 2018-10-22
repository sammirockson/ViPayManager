//
//  BusinessChatTableViewController.swift
//  ViPay
//
//  Created by Rock on 2018/10/6.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import Parse

class BizChatObject: NSObject {
    var text: String?
    var fileOne: PFFile?
    var imageURL: String?
    var senderId: String!
    var price: String?
    var descript: String?
}

class BusinessChatTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let identfier = "identfier"
    var incomingUser: PFUser?
    
    var BizChat = [BizChatObject]()
    
    let inputContainerView: UIView  = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.setTitleColor(defaultAppColor, for: .normal)
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()
    
    let addFileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(defaultAppColor, for: .normal)
        return button
    }()
    
    let messageContainer: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 2
        textView.clipsToBounds = true
        textView.font = OptimizedFont.font(fontName: FontNames.OpenSansRegular, fontSize: 15)
        return textView
    }()
    
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
      
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 54, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 54, right: 0)
        
        tableView.backgroundColor = UIColor.groupTableViewBackground

        tableView.register(BusinessChatTableViewCell.self, forCellReuseIdentifier: identfier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        if let displayName = incomingUser?.object(forKey: "displayName") as? String {
            navigationItem.title = displayName
        }
        
//        let sev = BizChatObject()
//        sev.text = " Product description says more about the product Product description says more about the product product Product description says more about the product."
//        sev.senderId = "Rock"
//        BizChat.append(sev)
//
//        let seven = BizChatObject()
//        seven.text = "Hi."
//        seven.senderId = "Rock"
//        BizChat.append(seven)
//
//
//        let four = BizChatObject()
//        four.product = PFObject(className: "somethingCool")
//        four.senderId = "rockkakakakka"
//        BizChat.append(four)
//
//        let one = BizChatObject()
//        one.product = PFObject(className: "test")
//        one.senderId = PFUser.current()?.objectId!
//        BizChat.append(one)
//
//        let two = BizChatObject()
//        two.imageURL = "fuckouthere"
//        two.senderId = PFUser.current()?.objectId!
//        BizChat.append(two)
//
//        let three = BizChatObject()
//        three.text = "try out motherfucker"
//        three.senderId = PFUser.current()?.objectId!
//        BizChat.append(three)
        
        
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard)))
        
      
    }
    
    @objc func handleDismissKeyboard(){
        messageContainer.resignFirstResponder()
    }
    
    func loadMessages(){
        
        let userOne = PFUser.current()!
        let userTwo = self.incomingUser!
        
        let pred = NSPredicate(format: "userOne = %@ AND userTwo = %@ OR userTwo = %@ AND userOne = %@", userOne,userTwo,userTwo,userOne)
        let query = PFQuery(className: "BizRoom", predicate: pred)
//        query.cachePolicy = PFCachePolicy.cacheElseNetwork
        query.findObjectsInBackground { (results, error) in
            if error == nil {
                if (results?.count)! > 0 {
                    if let room = results?.first {
                        let findMessages = PFQuery(className: "BizChat")
                        findMessages.includeKeys(["sender","product"])
                        findMessages.whereKey("room", equalTo: room)
                        findMessages.order(byDescending: "createdAt")
//                        findMessages.cachePolicy = PFCachePolicy.cacheThenNetwork
                        findMessages.findObjectsInBackground(block: { (messages, error) in
                            if error == nil {
                                if (messages?.count)! > 0 {
                                    
                                    for message in messages! {
                                        self.processMessage(object: message)
                                    }
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                        let indexPath = IndexPath(item: self.BizChat.count - 1, section: 0)
                                        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                                    }
                                    
                                }
                            }
                        })
                        
                        
                    }
                   
                    
                }
            }
        }
    }
    
    func processMessage(object: PFObject){
        let message = BizChatObject()

        if let text = object.object(forKey: "text") as? String {
            message.text = text
        }
        
        if let sender = object.object(forKey: "sender") as? PFUser {
            message.senderId = sender.objectId
        }
        
        if let fileOne = object.object(forKey: "fileOne") as? PFFile {
            message.fileOne = fileOne
        }
        
        if let description = object.object(forKey: "description") as? String {
            message.descript = description
        }
        
        if let price = object.object(forKey: "price") as? String {
            message.price = price
        }
        
        BizChat.insert(message, at: 0)
      

        
    }
    
    @objc func handleSendMessage(){
        //Send message
        //check if bizRoom exists else create new one
        
        if !self.messageContainer.text.isEmpty {
            
            let message = BizChatObject()
            message.text = self.messageContainer.text
            message.senderId = PFUser.current()?.objectId
            BizChat.append(message)
            self.tableView.reloadData()
            
            let indexPath = IndexPath(item: self.BizChat.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            let temporaryHoldText = self.messageContainer.text
            self.messageContainer.text = ""
            let userOne = PFUser.current()!
            let userTwo = self.incomingUser!

            let pred = NSPredicate(format: "userOne = %@ AND userTwo = %@ OR userTwo = %@ AND userOne = %@", userOne,userTwo,userTwo,userOne)
            let query = PFQuery(className: "BizRoom", predicate: pred)
//            query.cachePolicy = PFCachePolicy.cacheElseNetwork
            query.findObjectsInBackground { (results, error) in
                if error == nil {
                    if (results?.count)! > 0 {
                        if let room = results?.first {
                            
                            let chatMessage = PFObject(className: "BizChat")
                            chatMessage.setObject(PFUser.current()!, forKey: "sender")
                            chatMessage.setObject(PFUser.current()!.objectId!, forKey: "senderId")
                            chatMessage.setObject(temporaryHoldText!, forKey: "text")
                            chatMessage.setObject(room, forKey: "room")
                            chatMessage.saveInBackground(block: { (success, error) in
                                if error == nil {
                                    print("sent")
                                    //Send push to business
                                    
                                    
                                }
                            })
                            
                        }
                    }else{
                        
                        let room = PFObject(className: "BizRoom")
                        room.setObject(PFUser.current()!, forKey: "userOne")
                        room.setObject(self.incomingUser!, forKey: "userTwo")
                        room.saveInBackground(block: { (success, error) in
                            if success {
                               
                                let chatMessage = PFObject(className: "BizChat")
                                chatMessage.setObject(PFUser.current()!, forKey: "sender")
                                chatMessage.setObject(PFUser.current()!.objectId!, forKey: "senderId")
                                chatMessage.setObject(temporaryHoldText!, forKey: "text")
                                chatMessage.setObject(room, forKey: "room")
                                chatMessage.saveInBackground(block: { (success, error) in
                                    if error == nil {
                                        print("sent")
                                        //Send push to business
                                        
                                        
                                    }
                                })
                                
                            }
                        })
                        
                    }
                }
            }
            
            self.messageContainer.text = ""
            
        }
        
       
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        self.loadMessages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        navigationController?.isNavigationBarHidden = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.messageContainer.resignFirstResponder()
    }
    
    
    @objc func handleKeyboardWillShowNotification(notification: NSNotification){
        if let keyboardInfo = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            self.bottomConstraints?.constant = -(keyboardInfo.height)
            self.inputViewHeight?.constant = 54.all
            self.view.layoutIfNeeded()

            
//            let indexPath = IndexPath(row: 0, section: self.Messages.count - 1)
//            tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            
        }
        
        
    }
    
    @objc func handleKeyboardWillHideNotification(notification: NSNotification){
        
        self.bottomConstraints?.constant = 0
        if isCurvedDevice{
            self.inputViewHeight?.constant = 72.all
        }else{
            self.inputViewHeight?.constant = 54.all
        }
        self.view.layoutIfNeeded()

        
        
    }
    
    
    var bottomConstraints: NSLayoutConstraint?
    var inputViewHeight: NSLayoutConstraint?
    
    func setUpViews(){
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(inputContainerView)
        bottomConstraints = inputContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraints?.isActive = true
        inputContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        inputContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        if isCurvedDevice {
        inputViewHeight = inputContainerView.heightAnchor.constraint(equalToConstant: 72.all)
        inputViewHeight?.isActive = true
          }else{
        inputViewHeight = inputContainerView.heightAnchor.constraint(equalToConstant: 54.all)
        inputViewHeight?.isActive = true
        }
        
        inputContainerView.addSubview(sendButton)
        sendButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10.all)
            make.top.equalToSuperview().offset(10.all)
            make.height.equalTo(34.all)
            make.width.equalTo(44.all)
        }
        
        inputContainerView.addSubview(addFileButton)
        addFileButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10.all)
            make.top.equalToSuperview().offset(10.all)
            make.height.equalTo(34.all)
            make.width.equalTo(44.all)
        }
        
        inputContainerView.addSubview(messageContainer)
        messageContainer.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 10.all).isActive = true
        messageContainer.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -8.all).isActive = true
        messageContainer.leftAnchor.constraint(equalTo: addFileButton.rightAnchor, constant: 8.all).isActive = true
        messageContainer.heightAnchor.constraint(equalToConstant: 34.all).isActive = true
        
    }
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.BizChat.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identfier, for: indexPath) as! BusinessChatTableViewCell
        cell.backgroundColor = UIColor.groupTableViewBackground
        let chat = BizChat[indexPath.item]
        
        if let profileImagefile = PFUser.current()?.object(forKey: "profileImageFile") as? PFFile {
            let url = URL(string: profileImagefile.url!)
            cell.outgoingImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        
        if let fileOne = chat.fileOne {
            if let descript = chat.descript {
                cell.descriptionTextView.text = descript
            }
            
            if let price = chat.price {
                cell.priceLabel.text = "Ghc\(price)"
            }
            
//            if let fileOne = product.object(forKey: "fileOne") as? PFFile {
                let url = URL(string: fileOne.url!)
                cell.productImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
//            }
            
//            chatMessage.setObject(fileOne, forKey: "fileOne")
//            chatMessage.setObject(price, forKey: "price")
//            chatMessage.setObject(description, forKey: "description")
        }
        
        
        if chat.fileOne != nil {
            cell.productInfoView.isHidden = false
            cell.widthConstraint?.constant = 180.all
            cell.imageMessage.isHidden = true
            cell.messageTextView.isHidden = true
            cell.containerView.backgroundColor = .clear
        }else{
            cell.productInfoView.isHidden = true
        }
        
        if chat.imageURL != nil {
            cell.productInfoView.isHidden = true
            cell.imageMessage.isHidden = false
            cell.widthConstraint?.constant = 140.all
            cell.messageTextView.isHidden = true
            cell.containerView.backgroundColor = .clear
        }else{
            cell.imageMessage.isHidden = true
        }
        
        if chat.text != nil {
            cell.productInfoView.isHidden = true
            cell.messageTextView.text = chat.text
            
            cell.widthConstraint?.constant = self.estimatedRect(statusText: chat.text!, fontSize: 16).width + 24
            cell.imageMessage.isHidden = true
            cell.messageTextView.isHidden = false
            
            if let userId = PFUser.current()?.objectId, let senderId = chat.senderId {
                if senderId == userId {
                    cell.containerView.backgroundColor = UIColor(white: 0.1, alpha: 0.95)
                    cell.messageTextView.textColor = .white
                }else{
                    cell.containerView.backgroundColor = .white
                    cell.messageTextView.textColor = .black


                }
                
            }
        }else{
            cell.messageTextView.isHidden = true
        }
        
        if let userId = PFUser.current()?.objectId, let senderId = chat.senderId {
            if senderId == userId {
                
                cell.leftConstraint?.isActive = false
                cell.rightConstraint?.isActive = true
                
                cell.outgoingImageView.isHidden = false
                cell.incomingImageView.isHidden = true
            }else{
                
                cell.leftConstraint?.isActive = true
                cell.rightConstraint?.isActive = false
                
                cell.outgoingImageView.isHidden = true
                cell.incomingImageView.isHidden = false
            }
            
        }
       
        
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = BizChat[indexPath.row]
        if item.fileOne != nil  {
            return 280.all //Product
        }else if item.imageURL != nil {
            return 180.all // Image
        }else if item.text != nil {
            let text = item.text
            let height = self.estimatedRect(statusText: text!, fontSize: 16).height + 30
            return height.all //Text
        }else{
            return 0
        }
    }
    

    func estimatedRect(statusText: String, fontSize: CGFloat) -> CGRect {
        return NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width - 140, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedString.Key.font: OptimizedFont.font(fontName: FontNames.OpenSansRegular, fontSize: fontSize)], context: nil)
    }

}
