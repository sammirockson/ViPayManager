//
//  AddHouseViewController.swift
//  ViPayManager
//
//  Created by Rock on 2018/10/5.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import Parse
import CoreLocation
import GooglePlaces

class AddHouseViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {

    let buildingInfoContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var buildingTypeTextField: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.autocorrectionType = .no
        label.returnKeyType = .done
        label.placeholder = "House type e.g 2 Bedroom apartment"
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
        label.placeholder = "Size e.g 40m²"
        return label
    }()
    

    
    let breakfastSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        return sw
    }()
    
    let houseLocationContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.alpha = 0.65
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.text = "Location"
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePickLocation)))
        return label
    }()
    
    
    let isRentContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    let rentSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = true
        return sw
    }()
    
    lazy var rentTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.alpha = 0.65
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.text = "Renting"
        return label
    }()
    
    let  selectionNoticeLabel: UILabel = {
        let label = UILabel()
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.alpha = 0.65
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 12)
        label.text = "Please select available amenities"
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
        v.image = UIImage(named: "search")
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
//    lazy var selectedAmenities: SelectAmenitiesView = {
//        let v = SelectAmenitiesView()
//        v.layer.borderWidth = 0.1
//        v.layer.borderColor = defaultAppColor.cgColor
//        v.delegate = self
//        return v
//    }()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    var searchedPlace: GMSPlace?
    
    
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
    
    @objc func handlePickLocation(){
        let autoCompleteVC = GMSAutocompleteViewController()
        autoCompleteVC.delegate = self
        autoCompleteVC.navigationController?.navigationBar.barTintColor = defaultAppColor
        UIApplication.shared.statusBarStyle = .default
        let filter = GMSAutocompleteFilter()
        autoCompleteVC.autocompleteFilter = filter
        self.present(autoCompleteVC, animated: true, completion: nil)
        
    }
    
  
    var isRent = false
    
    @objc func handleNext(){
        
        if (self.buildingTypeTextField.text?.isEmpty)! {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Building type must be provided. E.g 3 Bedroom apartment")
            return
        }
        
        if (self.priceTextField.text?.isEmpty)! {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Please provide price per month if its for rent or sale's price if its for sale.")
            return
        }
        
        if (self.roomSizeTextField.text?.isEmpty)! {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Property size must be provided")
            return
        }

        
        if self.locationTitleLabel.text == "Location"{
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Please select ")
            return
        }
        

        
        if  rentSwitch.isOn {
            self.isRent = true
        }else{
            self.isRent = false
        }
        
        
        let houseObject = PFObject(className: "Housing")
        houseObject.setObject(PFUser.current()!, forKey: "company")
        houseObject.setObject(buildingTypeTextField.text!, forKey: "buildingType")
        houseObject.setObject(priceTextField.text!, forKey: "price")
        houseObject.setObject(roomSizeTextField.text!, forKey: "size")
        houseObject.setObject(self.isRent, forKey: "isRent")
        houseObject.setObject(true, forKey: "isAvailable")
        houseObject.setObject(locationTitleLabel.text!, forKey: "location")
        if let coordinates = self.searchedPlace?.coordinate {
            let PFLoc = PFGeoPoint(latitude: coordinates.latitude, longitude: coordinates.longitude)
            houseObject.setObject(PFLoc, forKey: "currentLocation")
        }
        
        let itemsArray: [AttachmentItems] = {
            let one = AttachmentItems.init(iconImage: UIImage(named: "kitchen")!, title: "Kitchen")
            let two = AttachmentItems.init(iconImage: UIImage(named: "wifi")!, title: "WiFi")
            let three = AttachmentItems.init(iconImage: UIImage(named: "closet")!, title: "Closet")
            let four = AttachmentItems.init(iconImage: UIImage(named: "couch")!, title: "Couch")
            let five = AttachmentItems.init(iconImage: UIImage(named: "TV")!, title: "TV")
            let six = AttachmentItems.init(iconImage: UIImage(named: "fridge")!, title: "Fridge")
            let seven = AttachmentItems.init(iconImage: UIImage(named: "laundry")!, title: "Laundry")
            let eight = AttachmentItems.init(iconImage: UIImage(named: "air-conditioner")!, title: "Air-conditioner")
            return [one,two,three,four,five,six,seven,eight]
        }()
       
        let completeVC = CompleteHotelAddViewController()
        completeVC.businessEntry = .housing
        completeVC.housingObject = houseObject
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
        self.buildingTypeTextField.resignFirstResponder()
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.darkView.alpha = 1
            self.bedTypePicker.frame = CGRect(x: 0, y: self.view.frame.height - 300.all, width: self.view.frame.width, height: 300.all)
        }) { (completed) in
            
        }
    }
    
    func setUpViews(){
        
        view.addSubview(buildingInfoContainerView)
        buildingInfoContainerView.addSubview(buildingTypeTextField)
        
        buildingTypeTextField.leftAnchor.constraint(equalTo: buildingInfoContainerView.leftAnchor, constant: 8.all).isActive = true
        buildingTypeTextField.rightAnchor.constraint(equalTo: buildingInfoContainerView.rightAnchor, constant: -8.all).isActive = true
        buildingTypeTextField.topAnchor.constraint(equalTo: buildingInfoContainerView.topAnchor, constant: 4.all).isActive = true
        buildingTypeTextField.bottomAnchor.constraint(equalTo: buildingInfoContainerView.bottomAnchor, constant: -4.all).isActive = true
        
        view.addSubview(priceContainerView)
        priceContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(buildingInfoContainerView.snp.bottom).offset(8.all)
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

        
        view.addSubview(houseLocationContainerView)
        houseLocationContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(roomSizeContainerView.snp.bottom).offset(8.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(50.all)
        }
        
        
        
        houseLocationContainerView.addSubview(dropDownImageView)
        
        dropDownImageView.rightAnchor.constraint(equalTo: houseLocationContainerView.rightAnchor, constant: -10).isActive = true
        dropDownImageView.centerYAnchor.constraint(equalTo: houseLocationContainerView.centerYAnchor).isActive = true
        dropDownImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        dropDownImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        houseLocationContainerView.addSubview(locationTitleLabel)
        locationTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.bottom.equalToSuperview().offset(-4.all)
        }
        
        
        view.addSubview(isRentContainerView)
        isRentContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(houseLocationContainerView.snp.bottom).offset(8.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(50.all)
        }
        
        isRentContainerView.addSubview(rentSwitch)
        rentSwitch.snp.makeConstraints { (make) in
            make.right.equalTo(isRentContainerView.snp.right).offset(-30.all)
            make.centerY.equalToSuperview()
            make.width.equalTo(30.all)
            make.height.equalTo(30.all)
        }
        
        isRentContainerView.addSubview(rentTitleLabel)
        rentTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4.all)
            make.right.equalToSuperview().offset(-48.all)
            make.left.equalToSuperview().offset(10.all)
            make.bottom.equalToSuperview().offset(-4.all)
        }
        
        
        buildingInfoContainerView.snp.makeConstraints { (make) in
            if isCurvedDevice {
                make.top.equalToSuperview().offset(100.all)
            }else{
                make.top.equalToSuperview().offset(80.all)
            }
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(50.all)
        }
    }

}

extension AddHouseViewController: SelectedItemsDelegate {
    func bedTypeSelected(city: String) {
        self.locationTitleLabel.text = city
    }
    
    func dismissSelf() {
        self.handleDismiss()
    }
    
    
}

extension AddHouseViewController: SelectedAmenitiesDelegate {
    func selectedItems(items: [String]) {
        print(items.count)
    }

}

extension AddHouseViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.searchedPlace = place
        self.locationTitleLabel.text = searchedPlace?.name
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    
}
