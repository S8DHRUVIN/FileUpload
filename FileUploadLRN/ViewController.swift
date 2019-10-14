//
//  ViewController.swift
//  FileUploadLRN
//
//  Created by Dhruvin Shiyani on 20/09/19.
//  Copyright © 2019 Dhruvin Shiyani. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imgUserUploadFile: UIImageView!
    
    
    @IBOutlet weak var txtStudentName: UITextField!
    @IBOutlet weak var txtStudentGender: UITextField!
    @IBOutlet weak var txtStudentEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var validate:Bool{
        if (txtStudentName.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            let alert = UIAlertController(title: "Meassage", message: "Please enter student Name!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        if (txtStudentGender.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            let alert = UIAlertController(title: "Meassage", message: "Please enter student Gender!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        if (txtStudentEmail.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            let alert = UIAlertController(title: "Meassage", message: "Please enter student Email!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        return true
    }
    
    
    @IBAction func btnUserUploadFile(_ sender: Any) {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnCancleAction(_ sender: Any) {
        
        //
        
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        
        //
        if validate{
            
            //
            API_FileUpload()
            
        }
        
    }
    
    
    
    
    func API_FileUpload(){
        
        let url = "http://localhost/ApiLogin/fileupload-api.php"
        
        let param:Parameters = ["st_name":txtStudentName.text!,
                                "st_gender":txtStudentGender.text!,
                                "st_email":txtStudentEmail.text!]
        
        //Alamofire.request(url , method: .post, parameters: param).responseJONS { (response) in
        
        let imageData = imgUserUploadFile.image!.jpegData(compressionQuality: 0.50)
            
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(imageData!, withName: "file123", fileName: "swift_file.png", mimeType: "image/pnd")
            for (key,value) in param {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: url)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //print Progress
                    print("uploading \(progress)")
                })
                upload.responseJSON { response in
                    print(response.result)
                }
            case .failure( _): break
                //print encodingError.description
            }
        
        }
    }
    
    
    
    func openGallery(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.allowsEditing = false
            imgPicker.sourceType = UIImagePickerController.SourceType.camera
            //imgPicker.allowsEditing = false
            self.present(imgPicker, animated: true , completion: nil)
            
        }else{
            
            let alert = UIAlertController(title: "waring", message: "no premission", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imgUserUploadFile.contentMode = .scaleToFill
            imgUserUploadFile.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                   
                   let imgPicker = UIImagePickerController()
                   imgPicker.delegate = self
                   imgPicker.allowsEditing = false
                   imgPicker.sourceType = UIImagePickerController.SourceType.camera
                   //imgPicker.allowsEditing = false
                   self.present(imgPicker, animated: true , completion: nil)
                   
               }else{
                   
                   let alert = UIAlertController(title: "waring", message: "no premission", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   self.present(alert, animated: true, completion: nil)
                   
               }
    }
    
    


}
