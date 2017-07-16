//
//  AddItemViewController.swift
//  ImageMinder
//
//  Created by user on 7/16/17.
//  Copyright © 2017 taterbait. All rights reserved.
//

import UIKit
import CoreData

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtSub: UITextField!

    @IBAction func addItem(_ sender: Any)
    {
        if txtTitle.text != "" && txtSub.text != ""
        {
            saveThis(title: txtTitle.text!, subtitle: txtSub.text!)
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
