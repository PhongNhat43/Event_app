//
//  ViewModel.swift
//  MVVM_App
//
//  Created by devsenior on 10/04/2023.
//

import Foundation
import RealmSwift
import UIKit
class EventViewModel: NSObject {
    
    static var sharedInstance = EventViewModel()
 
    var events = [Event]()
    
    typealias completionHandler = () -> Void
    
    let realm = try! Realm()
    
    func addEvent(event: Event, completion: completionHandler){
        self.realm.beginWrite()
        self.realm.add(event)
        try! self.realm.commitWrite()
        print("Task saved!")
        completion()
    }
    
    func loadTasks(completion: completionHandler) {
        self.realm.beginWrite()
        let savedEvents = self.realm.objects(Event.self)
        self.events.removeAll()
        self.events.append(contentsOf: savedEvents)
        try! self.realm.commitWrite()
        completion()
    }
    
    func editEvent(event: Event, updatedEvent: Event, completion: completionHandler ){
        self.realm.beginWrite()
        // xoa
        self.realm.delete(event)
        
        // them update
        self.realm.add(updatedEvent)
        try! self.realm.commitWrite()
        completion()
    }
    
    func deleteEvent(event: Event, eventIndex: Int, completion: completionHandler ){
        self.realm.beginWrite()
        self.realm.delete(event)
        try! self.realm.commitWrite()
        events.remove(at: eventIndex)
        completion()
    }




}
