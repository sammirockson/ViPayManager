//
//  CompleteHotelAddViewController.swift
//  ViPayManager
//
//  Created by Rock on 2018/10/4.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

struct AttachmentItems {
    var iconImage: UIImage
    var title: String
}

enum TypeOfBusinessEntry {
    case hotel
    case housing
}

class CompleteHotelAddViewController: UIViewController, UITextFieldDelegate {
    
    let taxContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var taxTextField: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.delegate = self
        label.autocorrectionType = .no
        label.returnKeyType = .done
        label.placeholder = "Tax e.g Ghc 5"
        label.keyboardType = .decimalPad
        return label
    }()
    
    lazy var selectAmenitiesContainerView: SelectAmenitiesView = {
        let v = SelectAmenitiesView()
        v.backgroundColor = lightGrayColor
//        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        v.delegate = self
        return v
    }()
    
    lazy var noticeTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 16)
        label.text = "  Please select available amenities"
        label.backgroundColor = .white
        return label
    }()
    
    lazy var pickImagesTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 14)
        label.text = "  Please select at least 2 photos of the room"
        label.backgroundColor = .white
        return label
    }()
   
    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
//        layout.scrollDirection = .horizontal
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.delegate = self
//        cv.dataSource = self
//        cv.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
//        return cv
//    }()
    
    lazy var selectedContentView: SelectedMediaView = {
        let v = SelectedMediaView()
        v.backgroundColor = .white
        v.motherVC = self
        return v
    }()
    
    fileprivate var selectedItems = [String]()
    var businessEntry: TypeOfBusinessEntry = .hotel
  
    
    var incomingObject: PFObject?
    var housingObject: PFObject?
    var itemsArray = [AttachmentItems]()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
        setUpViews()
        
        
        let rightBarButton = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(handleNext))
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        navigationItem.title = "Select amenities and photos"
        
        
        selectAmenitiesContainerView.itemsArray = itemsArray
        selectAmenitiesContainerView.collectionView.reloadData()


     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = defaultAppColor
        UIApplication.shared.statusBarStyle = .default
    }
    
    @objc func handleNext(){
        
        if (self.taxTextField.text?.isEmpty)! {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Tax amount must be provided")
            return
        }
        
        if self.selectedItems.count == 0 {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Please select available amenities")
            return
        }
        
        let imagesArray = self.selectedContentView.imagesArray
        if imagesArray.count < 2 {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Please select at least two photos of the property")
            return
        }
    
        if self.businessEntry == .hotel {
            self.saveHotel(imagesArray: imagesArray)
        }else if businessEntry == .housing {
            self.saveHousing(imagesArray: imagesArray)
        }
        
     
    
    }
    
    func saveHousing(imagesArray: [UIImage]){
        if let object = self.housingObject {
            
            switch imagesArray.count {
            case 2:
                let imageOne = imagesArray[0]
                object.setObject(converImageToFile(image: imageOne), forKey: "fileOne")
                let imageTwo = imagesArray[1]
                object.setObject(converImageToFile(image: imageTwo), forKey: "fileTwo")
                
            case 3:
                let imageOne = imagesArray[0]
                object.setObject(converImageToFile(image: imageOne), forKey: "fileOne")
                let imageTwo = imagesArray[1]
                object.setObject(converImageToFile(image: imageTwo), forKey: "fileTwo")
                let imageThree = imagesArray[2]
                object.setObject(converImageToFile(image: imageThree), forKey: "fileThree")
                
            case 4:
                let imageOne = imagesArray[0]
                object.setObject(converImageToFile(image: imageOne), forKey: "fileOne")
                let imageTwo = imagesArray[1]
                object.setObject(converImageToFile(image: imageTwo), forKey: "fileTwo")
                let imageThree = imagesArray[2]
                object.setObject(converImageToFile(image: imageThree), forKey: "fileThree")
                let imageFour = imagesArray[3]
                object.setObject(converImageToFile(image: imageFour), forKey: "imageFour")
            default:
                print("nothing")
            }
            
            DarkOverLay.sharedInstance.show()
            SVProgressHUD.show(withStatus: "Sit tight...")
            
            object.setObject(taxTextField.text!, forKey: "tax")
            object.setObject(self.selectedItems, forKey: "amenities")
            object.saveInBackground { (success, error) in
                DispatchQueue.main.async {
                    DarkOverLay.sharedInstance.dismiss()
                    SVProgressHUD.dismiss()
                    
                    if error == nil {
                        CustomAlerts.sharedInstance.showAlert(message: "Posted successfully", image: nil)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                            CustomAlerts.sharedInstance.dismiss()
                        })
                    }else{
                        CustomAlerts.sharedInstance.showAlert(message: (error?.localizedDescription)!, image: UIImage(named: "iconWarning"))
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                            CustomAlerts.sharedInstance.dismiss()
                        })
                        
                    }
                }
            }
            
        }
        
    }
    
    func saveHotel(imagesArray: [UIImage]){
        
        if let object = self.incomingObject {
            
            switch imagesArray.count {
            case 2:
                let imageOne = imagesArray[0]
                object.setObject(converImageToFile(image: imageOne), forKey: "fileOne")
                let imageTwo = imagesArray[1]
                object.setObject(converImageToFile(image: imageTwo), forKey: "fileTwo")
                
            case 3:
                let imageOne = imagesArray[0]
                object.setObject(converImageToFile(image: imageOne), forKey: "fileOne")
                let imageTwo = imagesArray[1]
                object.setObject(converImageToFile(image: imageTwo), forKey: "fileTwo")
                let imageThree = imagesArray[2]
                object.setObject(converImageToFile(image: imageThree), forKey: "fileThree")
                
            case 4:
                let imageOne = imagesArray[0]
                object.setObject(converImageToFile(image: imageOne), forKey: "fileOne")
                let imageTwo = imagesArray[1]
                object.setObject(converImageToFile(image: imageTwo), forKey: "fileTwo")
                let imageThree = imagesArray[2]
                object.setObject(converImageToFile(image: imageThree), forKey: "fileThree")
                let imageFour = imagesArray[3]
                object.setObject(converImageToFile(image: imageFour), forKey: "imageFour")
            default:
                print("nothing")
            }
            
            DarkOverLay.sharedInstance.show()
            SVProgressHUD.show(withStatus: "Sit tight...")
            
            object.setObject(taxTextField.text!, forKey: "tax")
            object.setObject(self.selectedItems, forKey: "amenities")
            object.saveInBackground { (success, error) in
                DispatchQueue.main.async {
                    DarkOverLay.sharedInstance.dismiss()
                    SVProgressHUD.dismiss()
                    
                    if error == nil {
                        CustomAlerts.sharedInstance.showAlert(message: "Posted successfully", image: nil)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                            CustomAlerts.sharedInstance.dismiss()
                        })
                    }else{
                        CustomAlerts.sharedInstance.showAlert(message: (error?.localizedDescription)!, image: UIImage(named: "iconWarning"))
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                            CustomAlerts.sharedInstance.dismiss()
                        })
                        
                    }
                }
            }
            
        }
        
       
    }
    
    func converImageToFile(image: UIImage)->PFFile{
        let imageData = image.jpegData(compressionQuality: 0.6)
        let file = PFFile(name: "file.jpg", data: imageData!)!
        return file
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
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
    
    func setUpViews(){
        
        view.addSubview(taxContainerView)
        taxContainerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(50.all)
        }
        taxContainerView.addSubview(taxTextField)
        taxTextField.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 8, bottom: -4, right: -8))
        }
        
        view.addSubview(noticeTitleLabel)
        noticeTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(taxContainerView.snp.bottom).offset(10.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(50.all)
        }
        
        view.addSubview(selectAmenitiesContainerView)
        selectAmenitiesContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(noticeTitleLabel.snp.bottom)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(200.all)
        }
        
        view.addSubview(pickImagesTitleLabel)
        pickImagesTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(selectAmenitiesContainerView.snp.bottom).offset(10.all)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(50.all)
        }
        
        view.addSubview(selectedContentView)
        selectedContentView.snp.makeConstraints { (make) in
            make.top.equalTo(pickImagesTitleLabel.snp.bottom)
            make.right.equalToSuperview().offset(-10.all)
            make.left.equalToSuperview().offset(10.all)
            make.height.equalTo(100.all)
        }
        
//        selectAmenitiesContainerView.addSubview(collectionView)
//        collectionView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
    }
    

}

extension CompleteHotelAddViewController: SelectedAmenitiesDelegate {
    func selectedItems(items: [String]) {
        self.selectedItems = items
    }
    
    
}

