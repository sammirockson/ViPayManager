//
//  PickItemsContainerView.swift
//  ViPayManager
//
//  Created by Rock on 2018/10/4.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

protocol SelectedItemsDelegate: class {
    func bedTypeSelected(city: String)
    func dismissSelf()
}

class PickItemsContainerView: UIView {

    var tripType: TripType?
    
    lazy var cancelLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0.8
        label.text = "Cancel"
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansSemiBold, fontSize: 16)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    let separatorLine: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        v.alpha = 0.2
        return v
    }()
    
    weak var delegate: SelectedItemsDelegate?
    
    fileprivate let identifier = "identifier"
    
    var itemsArray = ["Single", "Double","Triple", "Quad", "Queen-sized", "King", "Twin", "Double double", "Studio", "Mini-Suite", "Master-Suite"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleDismiss(){
        
        self.delegate?.dismissSelf()
    }
    
    func setUpViews(){
        self.addSubview(separatorLine)
        separatorLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50.all)
            make.height.equalTo(1.all)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        self.addSubview(cancelLabel)
        cancelLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8.all)
            make.height.equalTo(34.all)
            make.left.equalToSuperview().offset(15.all)
            make.width.equalTo(60.all)
        }
        
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLine.snp.bottom).offset(8.all)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    
    
}

extension PickItemsContainerView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = self.itemsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = self.itemsArray[indexPath.row]
        self.delegate?.bedTypeSelected(city: city)
        self.delegate?.dismissSelf()
    }

}
