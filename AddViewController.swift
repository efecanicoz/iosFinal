//
//  AddViewController.swift
//  final
//
//  Created by EFE İÇÖZ on 19/01/16.
//  Copyright © 2016 yildiz. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var remindSwitch: UISwitch!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    
    let times = ["Off", "10 Min", "30 Min", "1 Hour", "2 Hours", "4 Hours", "6 Hours", "12 Hours", "1 Day"];
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        descriptionText.layer.borderWidth = 1;
        descriptionText.layer.borderColor = UIColor.blackColor().CGColor;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if(segue.identifier == "saveSegue")
        {
            let svc = segue.destinationViewController as! ViewController;
            let newEntry:remindCell = remindCell.init();
            newEntry.title = titleText.text;
            newEntry.reminder = remindSwitch.on;
            newEntry.deadline = deadlinePicker.date;
            newEntry.desc = descriptionText.text;
            newEntry.priority = prioritySegment.selectedSegmentIndex;
            
            //calculation of reminder
            let selected = timePicker.selectedRowInComponent(0);
            if(selected == 1)//1 min
            {
                newEntry.remindTime = newEntry.deadline.dateByAddingTimeInterval(10*60);
            }
            else if(selected == 2)//30 min
            {
                newEntry.remindTime = newEntry.deadline.dateByAddingTimeInterval(30*60);
            }
            else if(selected == 3)//1 hour
            {
                newEntry.remindTime = newEntry.deadline.dateByAddingTimeInterval(60*60);
            }
            else if(selected == 4)//2 hours
            {
                newEntry.remindTime = newEntry.deadline.dateByAddingTimeInterval(2*60*60);
            }
            else if(selected == 5)//4 hours
            {
                newEntry.remindTime = newEntry.deadline.dateByAddingTimeInterval(4*60*60);
            }
            else if(selected == 6)//6 hours
            {
                newEntry.remindTime = newEntry.deadline.dateByAddingTimeInterval(6*60*60);
            }
            else if(selected == 7)//12 hours
            {
                newEntry.remindTime = newEntry.deadline.dateByAddingTimeInterval(12*60*60);
            }
            else if(selected == 8)//1 day
            {
                newEntry.remindTime = newEntry.deadline.dateByAddingTimeInterval(24*60*60);
            }
            
            svc.newItem = newEntry;
        }
        //send this element
    }
    
    //picker view
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return times.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return times[row]
    }
    //end of picker view related part
    
    
    @IBAction func switchChange(sender: UISwitch) {
        timePicker.userInteractionEnabled = sender.on;
        if(sender.on == false)
        {
            timePicker.selectRow(0, inComponent: 0, animated: true);
        }
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
