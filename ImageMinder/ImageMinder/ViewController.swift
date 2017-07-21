//
//  ViewController.swift
//  ImageMinder
//
//  Created by user on 7/16/17.
//  Copyright © 2017 taterbait. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

var titles:[String] = []
var subtitles:[String] = []
var thisItem = 0

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        cell.detailTextLabel?.text = subtitles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            thisItem = indexPath.row
            deleteThis()
            getThis()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        thisItem = indexPath.row
        performSegue(withIdentifier: "show", sender: self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initNotificationSetupCheck()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
    getThis()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Retrieve Data//
    //Boiler Plate CoreData Stuff
    func getThis(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminder")
    //do it or complain
        do
        {
            let results = try context.fetch(request)
            titles.removeAll()
            subtitles.removeAll()
            
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    //Get Title
                    if let myTitle = result.value(forKey: "title") as? String
                    {
                        titles.append(myTitle)
                    }
                    else
                    {
                        titles.append(" ")
                    }
                    //Get Subtitle
                    if let mySubtitle = result.value(forKey: "subtitle") as? String
                    {
                        subtitles.append(mySubtitle)
                    }
                    else
                    {
                        subtitles.append(" ")
                    }
                }
            }
            myTableView.reloadData()
        }
        catch
        {
            print("ERROR")
        }
    }

    //Delete Data//
    //Boiler Plate CoreData Stuff
    func deleteThis(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminder")
        //do it or complain
        do
        {
            let results = try context.fetch(request)
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    if let myTitle = result.value(forKey: "title") as? String
                    {
                        if myTitle == titles[thisItem]
                        {
                            context.delete(result)
                            
                            do
                            {
                                try context.save()
                            }
                            catch{
                                
                            }
                        }
                    }
                    
                }
            }
        }
        catch
        {

        }
    }
    
    //User Notification function
    func initNotificationSetupCheck() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert])
        { (success, error) in
            if success {
                print("Permission Granted")
            } else {
                print("There was a problem!")
            }
        }
    }
}

