//
//  EditViewController.swift
//  MVVM_App
//
//  Created by devsenior on 10/04/2023.
//

import UIKit

class EditViewController: UIViewController {
   
    var event: Event?
    var index: Int?
    let vm = EventViewModel.sharedInstance

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
        guard let image = imageEvent.image, let imageData = image.jpegData(compressionQuality: 0.5) else {
            // Handle the case where there is no image
            return
        }
        let newEvent = Event(title: titleTF.text ?? "", desc: descTDF.text ?? "", date: pickerDate.date, image: imageData as NSData)
        vm.editEvent(event: self.event!, updatedEvent: newEvent) {
            print("Event updated successfully")
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        if let eventIndex = self.index {
            vm.deleteEvent(event: self.event!, eventIndex: self.index!) {
                print("Delete successfully")
                navigationController?.popViewController(animated: true)
            }
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        if let myEvent = self.event {
            titleTF.text = myEvent.title
            descTDF.text = myEvent.desc
            pickerDate.date = myEvent.date
            if let imageData = myEvent.image, let image = UIImage(data: imageData as Data) {
                        imageEvent.image = image
                    }
        }
    }

}

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
