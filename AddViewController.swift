//
//  AddViewController.swift
//  final
//
//  Created by EFE İÇÖZ on 19/01/16.
//  Copyright © 2016 yildiz. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var pickerPriority: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSave(sender: AnyObject) {
        self.performSegueWithIdentifier("saveSegue", sender: self)
    }

    @IBAction func btnCancel(sender: AnyObject) {
        self.performSegueWithIdentifier("cancelSegue", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
