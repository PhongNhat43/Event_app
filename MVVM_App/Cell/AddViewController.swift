//
//  AddViewController.swift
//  MVVM_App
//
//  Created by devsenior on 10/04/2023.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet weak var descTDF: UITextField!
    
    @IBOutlet weak var pickerDate: UIDatePicker!

    @IBOutlet weak var imageEvent: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickImage))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        
        imageEvent.addGestureRecognizer(gesture)
        imageEvent.isUserInteractionEnabled = true
      
    }
    @objc func clickImage(gesture: UITapGestureRecognizer){
      let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    @IBAction func saveBtn(_ sender: Any) {
        let vm = EventViewModel.sharedInstance
           guard let image = imageEvent.image, let imageData = image.jpegData(compressionQuality: 0.5) else {
               // Handle the case where there is no image
               return
           }
           let event = Event(title: titleTF.text ?? "", desc: descTDF.text ?? "", date: pickerDate.date, image: imageData as NSData)
           vm.addEvent(event: event) {
               self.navigationController?.popViewController(animated: true)
           }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelect = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageEvent.image = imageSelect
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
   
}
