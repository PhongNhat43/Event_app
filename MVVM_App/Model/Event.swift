//
//  Animal.swift
//  MVVM_App
//
//  Created by devsenior on 10/04/2023.
//

import UIKit
import RealmSwift

class Event: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var desc: String = ""
//    @objc dynamic var _id: ObjectId = ObjectId.generate()
    @objc dynamic var date: Date = Date()
    @objc dynamic var image: NSData?
    
    override init() {
        super.init()
    }
    

    init(title: String, desc: String, date: Date, image: NSData?) {
        self.title = title
        self.desc = desc
        self.date = date
        self.image = image
    }
    
//    override static func primaryKey() -> String {
//        return "_id"
//    }

}
