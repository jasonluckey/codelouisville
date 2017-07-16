//
//  ViewReminderViewController.swift
//  ImageMinder
//
//  Created by user on 7/16/17.
//  Copyright © 2017 taterbait. All rights reserved.
//

import UIKit

class ViewReminderViewController: UIViewController {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtSub: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        txtTitle.text = titles[thisItem]
        txtSub.text = subtitles[thisItem]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
