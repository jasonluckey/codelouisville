//
//  AddItemViewController.swift
//  ImageMinder
//
//  Created by user on 7/16/17.
//  Copyright © 2017 taterbait. All rights reserved.
//
import UIKit
import CoreData
import UserNotifications

//items in PickerView
enum Interval: String {
    case minutes = "Minutes"
    case hours = "Hours"
    case days = "Days"
    case weeks = "Weeks"
    case months = "Months"
    case years = "Years"
    
    var multiplier: Double {
        switch self {
            
        case .minutes :
            return 60
            
        case .hours :
            return 3600
            
        case .days :
            return 86400
            
        case .weeks :
            return 604800
            
        case .months:
            return 604800
            
        case .years:
            return 6622560000
            
        }
    }
}

let pickerDataArray = [
    Interval.minutes.rawValue,
    Interval.hours.rawValue,
    Interval.days.rawValue,
    Interval.weeks.rawValue,
    Interval.months.rawValue,
    Interval.years.rawValue,
]

var pickerView = Interval.minutes.rawValue

class AddItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtSub: UITextField!
    @IBOutlet weak var selectedChoice: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return pickerDataArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerDataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedChoice.text = pickerDataArray[row]
    }
   
    @IBAction func addItem(_ sender: Any)
    {
        if txtTitle.text != "" && txtSub.text != ""
        {
            saveThis(title: txtTitle.text!, subtitle: txtSub.text! + " " + selectedChoice.text!)
            txtTitle.text = ""
            txtSub.text = ""
                        
            let notification = UNMutableNotificationContent()
            notification.title = "ImageMinder"
            notification.subtitle = "\(txtSub.text)"
            
            /*let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: thing, repeats: false)
            let request = UNNotificationRequest(identifier: "notification1", content: notification, trigger: notificationTrigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil) */
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let thing = ("Thing", Interval(rawValue: "Minutes")!)
        thing.1.multiplier
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Save Data//
    //Boiler Plate CoreData Stuff
    func saveThis(title: String, subtitle: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Reminder", into: context)
        
        //data
        newItem.setValue(title, forKey: "title")
        newItem.setValue(subtitle, forKey: "subtitle")
        //do it or complain
        do
        {
            try context.save()
            print("SAVE")
        }
        catch
        {
            print("ERROR")
        }
    
        
    }
    
    
}
