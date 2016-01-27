//
//  showInfoView.swift
//  final
//
//  Created by EFE İÇÖZ on 26/01/16.
//  Copyright © 2016 yildiz. All rights reserved.
//

import UIKit

class showInfoView: UIViewController
{
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRemind: UILabel!
    @IBOutlet weak var lblDue: UILabel!
    @IBOutlet weak var viewDescription: UITextView!
    @IBOutlet weak var lblPriority: UILabel!
    
    var toShow: remindCell = remindCell.init();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let formatter = NSDateFormatter();
        formatter.dateFormat =  "yyyy-MM-dd HH:mm:ss xx";
        lblTitle.text = lblTitle.text! + toShow.title;
        lblRemind.text = lblRemind.text! + formatter.stringFromDate(toShow.remindTime);
        lblDue.text = lblDue.text! + formatter.stringFromDate(toShow.deadline);
        lblPriority.text = lblPriority.text! + (toShow.priority == 0 ? "High" : (toShow.priority == 1 ? "Mid" : "Low"));
        viewDescription.text = viewDescription.text + toShow.desc;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
