//
//  AddItemViewController.swift
//  ImageMinder
//
//  Created by user on 7/16/17.
//  Copyright © 2017 taterbait. All rights reserved.
//

import UIKit
import CoreData

//var date = txtSub * selectedInterval

class AddItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtSub: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var selectedChoice: UILabel!
    
    
    //items in PickerView
    
    let intervals = ["Minutes", "Hours", "Days", "Weeks", "Months", "Years"]
    var selectedInterval = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return intervals[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return intervals.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedChoice.text = intervals[row]
    }
    
    
    @IBAction func addItem(_ sender: Any)
    {
        if txtTitle.text != "" && txtSub.text != ""
        {
            saveThis(title: txtTitle.text!, subtitle: txtSub.text! + selectedChoice.text!)
            txtTitle.text = ""
            txtSub.text = ""
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
