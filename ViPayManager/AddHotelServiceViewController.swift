//
//  AddHotelServiceViewController.swift
//  ViPayManager
//
//  Created by Rock on 2018/10/3.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

class AddHotelServiceViewController: UIViewController, UITextFieldDelegate,CLLocationManagerDelegate {
    
    //Room name Presidential suite
    //Price
    //isAvailabel
    //Meal
    //Bed type
    //Internet
    //Air con
    //PhoneNumber
    
    let roomInfoContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
  
    lazy var roomInfoTextField: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.autocorrectionType = .no
        label.returnKeyType = .done
        label.placeholder = "Room Information"
        return label
    }()
    
    let priceContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var priceTextField: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.delegate = self
        label.autocorrectionType = .no
        label.returnKeyType = .done
        label.keyboardType = .decimalPad
        label.placeholder = "Price"
        return label
    }()
    
    let roomSizeContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var roomSizeTextField: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.delegate = self
        label.autocorrectionType = .no
        label.returnKeyType = .done
        label.keyboardType = .numberPad
        label.placeholder = "Room size e.g 40m²"
        return label
    }()
    
    let occupancyContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var occupancyTitleLabel: UITextField = {
        let label = UITextField()
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.delegate = self
        label.autocorrectionType = .no
        label.returnKeyType = .done
        label.keyboardType = .numberPad
        label.placeholder = "Max Occupancy"
        return label
    }()
    
    let mealContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var mealTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.alpha = 0.65
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.text = "Breakfast"
        return label
    }()
    
    let breakfastSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        return sw
    }()
    
    let bedTypeContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var bedTypeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.alpha = 0.65
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.text = "Bed type"
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBedTypePicker)))
        return label
    }()
    
    let internetContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    let internetSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = true
        return sw
    }()
    
    let internetTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.alpha = 0.65
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.text = "WiFi"
        return label
    }()
    
    
    let airConContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    let airConditionerSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        return sw
    }()
    
      let  airConditionerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.alpha = 0.65
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.text = "Air Conditioner"
        return label
    }()
    
    lazy var bedTypePicker: PickItemsContainerView = {
        let bedtype = PickItemsContainerView(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 300.all))
        bedtype.backgroundColor = .white
        bedtype.delegate = self
        return bedtype
    }()
    
    lazy var darkView: UIView = {
        let v = UIView(frame: view.frame)
        v.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
        v.alpha = 0
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        return v
    }()
    
    let dropDownImageView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "drop-down")
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Room"
        
        view.backgroundColor = UIColor.white
        setUpViews()
        let rightBarButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(handleNext))
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        
        view.addSubview(darkView)
        view.addSubview(bedTypePicker)
        
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }else{
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Turn on your location to enable us detect your company location.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = defaultAppColor
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        self.currentLocation = userLocation.coordinate
        manager.stopUpdatingLocation()
    }
    
    var breakfastStatus = false
    var wifiStatus = false
    var ACStatus = false
    
    @objc func handleNext(){
        
        if (self.roomInfoTextField.text?.isEmpty)! {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Short description must be provided")
            return
        }
        
        if (self.priceTextField.text?.isEmpty)! {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Room's original price without tax must be provided")
            return
        }
        
        if (self.roomSizeTextField.text?.isEmpty)! {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Room size must be provided")
            return
        }
        
        if (self.occupancyTitleLabel.text?.isEmpty)! {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Maximum number of occupancy must be provided")
            return
        }
        
        if self.bedTypeTitleLabel.text == "Bed type"{
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Please select bed type")
            return
        }
        
        if  breakfastSwitch.isOn {
            self.breakfastStatus = true
        }else{
            self.breakfastStatus = false
        }
        
        if  internetSwitch.isOn {
            self.wifiStatus = true
        }else{
            self.wifiStatus = false
        }
        
        if  airConditionerSwitch.isOn {
            self.ACStatus = true
        }else{
            self.ACStatus = false
        }
        
        
        let itemsArray: [AttachmentItems] = {
            let one = AttachmentItems.init(iconImage: UIImage(named: "dryer")!, title: "Hair dryer")
            let two = AttachmentItems.init(iconImage: UIImage(named: "bathtub")!, title: "Bathtub")
            let three = AttachmentItems.init(iconImage: UIImage(named: "closet")!, title: "Closet")
            let four = AttachmentItems.init(iconImage: UIImage(named: "stage")!, title: "Window")
            let five = AttachmentItems.init(iconImage: UIImage(named: "TV")!, title: "TV")
            let six = AttachmentItems.init(iconImage: UIImage(named: "fridge")!, title: "Fridge")
            let seven = AttachmentItems.init(iconImage: UIImage(named: "laundry")!, title: "Laundry")
            let eight = AttachmentItems.init(iconImage: UIImage(named: "air-conditioner")!, title: "Air-conditioner")
            return [one,two,three,four,five,six,seven,eight]
        }()

        
     
        
        let hotelObject = PFObject(className: "HotelService")
        hotelObject.setObject(PFUser.current()!, forKey: "company")
        hotelObject.setObject(roomInfoTextField.text!, forKey: "roomInfo")
        hotelObject.setObject(priceTextField.text!, forKey: "price")
        hotelObject.setObject(roomSizeTextField.text!, forKey: "size")
        hotelObject.setObject(occupancyTitleLabel.text!, forKey: "occupancy")
        hotelObject.setObject(self.breakfastStatus, forKey: "breakfast")
        hotelObject.setObject(self.wifiStatus, forKey: "wifi")
        hotelObject.setObject(self.ACStatus, forKey: "aircon")
        hotelObject.setObject(true, forKey: "isAvailable")
        hotelObject.setObject(bedTypeTitleLabel.text!, forKey: "bedType")
        if let coordinates = self.currentLocation {
            let PFLoc = PFGeoPoint(latitude: coordinates.latitude, longitude: coordinates.longitude)
            hotelObject.setObject(PFLoc, forKey: "currentLocation")
        }

        let completeVC = CompleteHotelAddViewController()
        completeVC.incomingObject = hotelObject
        completeVC.businessEntry = .hotel
        completeVC.itemsArray = itemsArray
        navigationController?.pushViewController(completeVC, animated: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text
        
        if (text?.contains("."))! && string == "." || text?.utf8.count == 0 && string == "."{
            return false
        }else{
            
            let maxLength = 10
            
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
    }
    
    @objc func handleDismiss(){
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.darkView.alpha = 0
            self.bedTypePicker.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 300.all)
        }) { (completed) in
            
        }
    }
    
    @objc func handleBedTypePicker(){
        self.mealTitleLabel.resignFirstResponder()
        self.occupancyTitleLabel.resignFirstResponder()
        self.roomInfoTextField.resignFirstResponder()
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.darkView.alpha = 1
            self.bedTypePicker.frame = CGRect(x: 0, y: self.view.frame.height - 300.all, width: self.view.frame.width, height: 300.all)
        }) { (completed) in
            
        }
    }
    
    func setUpViews(){
        
        view.addSubview(roomInfoContainerView)
        roomInfoContainerView.addSubview(roomInfoTextField)
        view.addSubview(priceContainerView)
        
        
        
        roomInfoTextField.leftAnchor.constraint(equalTo: roomInfoContainerView.leftAnchor, constant: 8.all).isActive = true
        roomInfoTextField.rightAnchor.constraint(equalTo: roomInfoContainerView.rightAnchor, constant: -8.all).isActive = true
        roomInfoTextField.topAnchor.constraint(equalTo: roomInfoContainerView.topAnchor, constant: 4.all).isActive = true
        roomInfoTextField.bottomAnchor.constraint(equalTo: roomInfoContainerView.bottomAnchor, constant: -4.all).isActive = true
    
        view.addSubview(priceContainerView)
        priceContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(roomInfoContainerView.snp.bottom).offset(8.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(50.all)
        }
        
        
        priceContainerView.addSubview(priceTextField)
        priceTextField.snp.makeConstraints { (make) in
            make.top.equalTo(priceContainerView.snp.top).offset(4.all)
            make.right.equalToSuperview().offset(-8.all)
            make.left.equalToSuperview().offset(8.all)
            make.bottom.equalToSuperview().offset(-4.all)
        }
        
        view.addSubview(roomSizeContainerView)
        roomSizeContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(priceContainerView.snp.bottom).offset(8.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(50.all)
        }
        roomSizeContainerView.addSubview(roomSizeTextField)
        roomSizeTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4.all)
            make.right.equalToSuperview().offset(-8.all)
            make.left.equalToSuperview().offset(8.all)
            make.bottom.equalToSuperview().offset(-4.all)
        }
        
        view.addSubview(occupancyContainerView)
        occupancyContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(roomSizeContainerView.snp.bottom).offset(8.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(50.all)
        }
        occupancyContainerView.addSubview(occupancyTitleLabel)
        occupancyTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.bottom.equalToSuperview().offset(-4.all)
        }
        
        view.addSubview(bedTypeContainerView)
        bedTypeContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(occupancyContainerView.snp.bottom).offset(8.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(50.all)
        }
        
        bedTypeContainerView.addSubview(dropDownImageView)
        
        dropDownImageView.rightAnchor.constraint(equalTo: bedTypeContainerView.rightAnchor, constant: -10).isActive = true
        dropDownImageView.centerYAnchor.constraint(equalTo: bedTypeContainerView.centerYAnchor).isActive = true
        dropDownImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        dropDownImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        bedTypeContainerView.addSubview(bedTypeTitleLabel)
        bedTypeTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.bottom.equalToSuperview().offset(-4.all)
        }
        
        view.addSubview(mealContainerView)
        mealContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(bedTypeContainerView.snp.bottom).offset(8.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(50.all)
        }
        
        mealContainerView.addSubview(breakfastSwitch)
        breakfastSwitch.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-30.all)
            make.centerY.equalToSuperview()
            make.width.equalTo(30.all)
            make.height.equalTo(30.all)
        }
        
        mealContainerView.addSubview(mealTitleLabel)
        mealTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4.all)
            make.right.equalToSuperview().offset(-70.all)
            make.left.equalToSuperview().offset(10.all)
            make.bottom.equalToSuperview().offset(-4.all)
        }
        
        
    
        
        view.addSubview(internetContainerView)
        internetContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(mealContainerView.snp.bottom).offset(8.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(50.all)
        }
        
        internetContainerView.addSubview(internetSwitch)
        internetSwitch.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-30.all)
            make.centerY.equalToSuperview()
            make.width.equalTo(30.all)
            make.height.equalTo(30.all)
        }
        internetContainerView.addSubview(internetTitleLabel)
        internetTitleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(internetSwitch.snp.right).offset(-8.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(42.all)
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(airConContainerView)
        airConContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(internetContainerView.snp.bottom).offset(8.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(50.all)
        }
        
        airConContainerView.addSubview(airConditionerSwitch)
        airConditionerSwitch.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-30.all)
            make.centerY.equalToSuperview()
            make.width.equalTo(30.all)
            make.height.equalTo(30.all)
        }
        airConContainerView.addSubview(airConditionerTitleLabel)
        airConditionerTitleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(airConditionerSwitch.snp.right).offset(-8.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(42.all)
            make.centerY.equalToSuperview()
        }
        
        roomInfoContainerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(50.all)
        }
    }


}

extension AddHotelServiceViewController: SelectedItemsDelegate {
    func bedTypeSelected(city: String) {
        self.bedTypeTitleLabel.text = city
    }
    
    func dismissSelf() {
        self.handleDismiss()
    }
    
    
}
