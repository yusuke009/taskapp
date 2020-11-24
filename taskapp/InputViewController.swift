//
//  InputViewController.swift
//  taskapp
//
//  Created by 齋藤友祐 on 2020/11/23.
//  Copyright © 2020 yusuke.saito. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class InputViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let realm = try! Realm()
    var task: Task!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        titleTextField.text = task.title
        contentsTextView.text = task.contents
        datePicker.date = task.date
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write {
            self.task.title = self.titleTextField.text!
            self.task.contents = self.contentsTextView.text
            self.task.date = self.datePicker.date
            self.realm.add(self.task, update: .modified)
        }
        
        setNotification(task: task)
        
        super.viewWillDisappear(animated)
        
    }
    
    func setNotification(task: Task) {
    let content = UNMutableNotificationContent()
   
    if task.title == "" {
        content.title = "(タイトルなし)"
    } else {
        content.title = task.title
    }
    if task.contents == "" {
        content.body = "(内容なし)"
    } else {
        content.body = task.contents
    }
    content.sound = UNNotificationSound.default
        
    let calendar = Calendar.current
        
    let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: task.date)
        
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
    let request = UNNotificationRequest(identifier: String(task.id), content: content, trigger: trigger)
        
    let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
        print(error ?? "ローカル通知登録 OK")
               }
        
        center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            for request in requests {
                print("/---------------")
                print(request)
                print("---------------/")
                   }
               }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
