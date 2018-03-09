//
//  AddPhotoViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/24/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

class AddPhotoViewController: ParentViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var viewPhotoSource: UIView!
    @IBOutlet var viewBackGround: UIView!
    @IBOutlet var btnPhoto: UIButton!
    
    var imagePicker = UIImagePickerController()
    var questionId = String()
    var mediaSaved = true
    
    var imageFile: String {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuration(){
        
        self.title = "Add Photo"
        imagePicker.delegate = self
        imagePicker.navigationBar.barTintColor = ColorMainBlue
        imagePicker.allowsEditing = false
        // load image if exists
        getQuestionImgIfExists()
        configureBackBtn()
    }
    
    
    func configureBackBtn(){
        
        let btn = UIButton.init(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "back-NoShadow"), for: .normal)
        btn.setTitle(" Back", for: .normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(self.backBtnClicked), for: .touchUpInside)
        let barBtn = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = barBtn
    }
    
    @objc func backBtnClicked(){
        
        if mediaSaved{
            self.navigationController?.popViewController(animated: true)
        }else{
            showYesNoAlert(title: "Attention", message: "Unsaved media will be discarded.", vc: self, firstBtnTitle: "Discard", secondBtnTitle: "Cancel", closure: { (exit) in
                if exit{
                    
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    @IBAction func btnGalleryClicked(_ sender: UIButton) {
        
        mediaSaved = false
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: {
            self.imagePicker.navigationBar.topItem?.rightBarButtonItem?.tintColor = .white
        })
    }
    @IBAction func btnCameraClicked(_ sender: UIButton) {
        
        mediaSaved = false
        self.imagePicker.sourceType = .camera
        self.present(self.imagePicker, animated: true, completion: {
            self.imagePicker.navigationBar.topItem?.rightBarButtonItem?.tintColor = .white
        })
    }
    
    @IBAction func btnCancelClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        
        do {
            
            if btnPhoto.currentImage != nil && btnPhoto.currentImage != #imageLiteral(resourceName: "plusGray"){
                
                showLoaderFor(view: self.view)
                
                let img = btnPhoto.currentImage
                
                let imgData = UIImagePNGRepresentation(img!)
                
                let imgName = "\(questionId).png"
                
                let imgPath =  URL.init(fileURLWithPath: imageFile).appendingPathComponent(imgName)
                
                try imgData?.write(to: imgPath, options: Data.WritingOptions.atomic)
                
                let predicateQuery = NSPredicate.init(format: "Id == %@", questionId)
                
                if let question = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first, imgData != nil{
                    
                    try realm?.write {
                        
                        question.photoPath = imgName
                        
                        realm?.add(question, update: true)
                    }
                    self.mediaSaved = true
                }
                
                hideLoaderFor(view: self.view)
            }
            
        }catch let err{
            
            hideLoaderFor(view: self.view)
            
            showAlert(title: "Error", message: err.localizedDescription, vc: self, closure: nil)
        }
        
    }
    
    func getQuestionImgIfExists(){
        
        do {
            
            showLoaderFor(view: self.view)
            
            let predicateQuery = NSPredicate.init(format: "Id == %@", questionId)
            
            
            if let question = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first{
                
                if let imgName = question.photoPath{
                    
                    if let img = self.loadImageFromName(imgName){
                        
                        self.btnPhoto.setImage(img, for: .normal)
                    }
                }
            }
            hideLoaderFor(view: self.view)
            
        }catch let err{
            
            hideLoaderFor(view: self.view)
            
            showAlert(title: "Error", message: err.localizedDescription, vc: self, closure: nil)
        }
    }
    
    func loadImageFromName(_ imgName: String) -> UIImage? {
        
        guard  imgName.characters.count > 0 else {
            print("ERROR: No image name")
            return #imageLiteral(resourceName: "plusGray")
        }
        
        let imgPath = imageFile + "/" + imgName
        let image = UIImage.init(contentsOfFile: imgPath)
        return image
    }
    
    @IBAction func btnAddPhotoClicked(_ sender: UIButton) {
        
        if self.btnPhoto.currentImage != #imageLiteral(resourceName: "plusGray"){
            
            ChangeOrRemovePhoto()
            
        }else{
            checkPhotoPermission()
        }
    }
    

    func ChangeOrRemovePhoto() {
        
        let alertController = UIAlertController(title: "Options: ", message: "", preferredStyle: .actionSheet)
        
        let changeButton = UIAlertAction(title: "Change photo", style: .default, handler: { (action) -> Void in
            self.checkPhotoPermission()
        })
        
        let removeButton = UIAlertAction(title: "Remove photo", style: .default, handler: { (action) -> Void in
            
            self.btnPhoto.setImage(#imageLiteral(resourceName: "plusGray"), for: .normal)
        })
        
        alertController.view.tintColor = ColorMainBlue
        alertController.addAction(changeButton)
        alertController.addAction(removeButton)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelButton)
        alertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkPhotoPermission(){
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
            
        case .authorized:
            self.choosePhotoSource()
            
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(
                
                {(newStatus) in
                    if newStatus ==  PHAuthorizationStatus.authorized {
                        DispatchQueue.main.async {
                            self.choosePhotoSource()
                        }
                    }
            })
            print("It is not determined until now")
        case .restricted:
            print("User do not have access to photo album.")
        case .denied:
            print("User has denied the permission.")
        }
    }
    
    func choosePhotoSource() {
        
        viewBackGround.isHidden = false
        viewPhotoSource.isHidden = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        viewBackGround.isHidden = true
        viewPhotoSource.isHidden = true
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            self.btnPhoto.setImage(image, for: .normal)
//            if picker.sourceType.rawValue == 1{ //1 refer to camera
//
//                mediaFileName = UUID().uuidString
//                mimeType = "image/jpeg"
//
//            }
            
        }
        if let mediaRef = info[UIImagePickerControllerReferenceURL] as? URL{
            // handle images and videos from library
//            if picker.sourceType.rawValue == 0{ // 0 refer to library
//                mediaFileName = (mediaRef.query)!
//                mimeType = self.mimeTypeForPath(path: mediaRef)
//            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func mimeTypeForPath(path: URL) -> String {
        
        let pathExtension = path.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }

}
