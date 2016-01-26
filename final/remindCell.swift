//
//  remindCell.swift
//  final
//
//  Created by EFE İÇÖZ on 21/01/16.
//  Copyright © 2016 yildiz. All rights reserved.
//

import UIKit

class remindCell
{
    var title:String! = "";
    var reminder: Bool=false;
    var remindTime:NSDate = NSDate.init();
    var deadline: NSDate = NSDate.init();
    var desc:String = "";
    var priority:Int = 0;
    var done: Bool = false;
    
    init(deadline: NSDate, title: String, reminder: Bool, remindTime:NSDate, desc:String, priority:Int, done: Bool ) {
        self.deadline = deadline
        self.title = title
        self.reminder = reminder
        self.remindTime = remindTime
        self.desc = desc
        self.priority = priority
        self.done = done
    }
    
    init()
    {
        //do nothing
    }
    
    var isOverdue: Bool {
        return (NSDate().compare(self.deadline) == NSComparisonResult.OrderedDescending) // deadline is earlier than current date
    }
}
