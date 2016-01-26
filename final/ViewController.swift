//
//  ViewController.swift
//  final
//
//  Created by yildiz on 1/14/16.
//  Copyright © 2016 yildiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tableReminder: UITableView!
    var newItem: remindCell? = nil;
    
    var itemList: [remindCell] = [];
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableReminder.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //read entries from file
        let fp = "list3.txt";
        if let dir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
        {
            let path = dir.stringByAppendingPathComponent(fp);
            let formatter = NSDateFormatter();
            formatter.dateFormat =  "yyyy-MM-dd HH:mm:ss xx";
            formatter.timeZone = NSTimeZone(abbreviation: "UTC")
            do
            {
                let fcontent = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                
                let blocks = fcontent.componentsSeparatedByString(";")
                
                for row in blocks
                {
                    if(row != "")
                    {
                        let item:remindCell = remindCell.init();
                        let dic = row.componentsSeparatedByString(",")
                        item.title = dic[0];
                        item.reminder =  dic[1] == "true" ? true : false;
                        item.deadline = formatter.dateFromString(dic[2])!;
                        item.remindTime = formatter.dateFromString(dic[3])!;
                        item.desc = dic[4];
                        item.priority = Int(dic[5])!
                        item.done = dic[6] == "true" ? true : false;
                        
                        itemList.append(item);
                        
                    }
                }
            }
            catch
            {
                //empty list
            }
        }
        
        if(newItem != nil)
        {
            itemList.append(newItem!);
            let notification = UILocalNotification()
            notification.alertBody = "Todo Item \"\(newItem!.title)\" Is Overdue" // text that will be displayed in the notification
            notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
            notification.fireDate = newItem!.deadline // todo item due date (when notification will be fired)
            notification.soundName = UILocalNotificationDefaultSoundName // play default sound
            notification.userInfo = ["UUID": newItem!.title ] // assign a unique identifier to the notification so that we can retrieve it later
            notification.category = "TODO_CATEGORY"
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }

    func saveFiles()
    {
        let fp = "list3.txt";
        var str : String = "";
        for cell in itemList
        {
            str += cell.title + "," + cell.reminder.description + "," + cell.deadline.description;
            str += "," + cell.remindTime.description + "," + cell.desc;
            str += "," + cell.priority.description + "," + cell.done.description + ";";
        }
        if let dir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = dir.stringByAppendingPathComponent(fp);
            //writing
            do
            {
                try str.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
            }
            catch {NSLog("Error while writing file")}
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "showInfoSegue")
        {
            let svc = segue.destinationViewController as! showInfoView;
            let index = tableReminder.indexPathForSelectedRow;
            svc.toShow = itemList[(index?.row)!];
        }
    }
    
    
    @IBAction func btnAdd(sender: UIButton)
    {
        //save items to file
        saveFiles();
        //call segue
        self.performSegueWithIdentifier("addPageSegue", sender: self)
    }

    @IBAction func btnFind(sender: UIButton) {
        //select a job from list depending on their priority
    }
    
    //tableview related
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.itemList.count;
    }
    
    //filling table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = self.tableReminder.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.itemList[indexPath.row].title
        cell.contentView.backgroundColor = UIColor.lightGrayColor();
        
        if(itemList[indexPath.row].priority == 0)
        {
            cell.textLabel?.textColor = UIColor.redColor();
        }
        else if(itemList[indexPath.row].priority == 1)
        {
            cell.textLabel?.textColor = UIColor.yellowColor();
        }
        else if(itemList[indexPath.row].priority == 2)
        {
            cell.textLabel?.textColor = UIColor.greenColor();
        }

        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.performSegueWithIdentifier("showInfoSegue", sender: self)
        return;
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if (editingStyle == UITableViewCellEditingStyle.Delete)
        {
            itemList.removeAtIndex(indexPath.row);
            tableReminder.deleteRowsAtIndexPaths([indexPath],  withRowAnimation: UITableViewRowAnimation.Automatic);
        }
    }
}

