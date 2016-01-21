//
//  ViewController.swift
//  final
//
//  Created by yildiz on 1/14/16.
//  Copyright © 2016 yildiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var newItem: remindCell = remindCell.init();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnAdd(sender: UIButton) {
        self.performSegueWithIdentifier("addPageSegue", sender: self)
    }

    @IBAction func btnFind(sender: UIButton) {
        //select a job from list depending on their priority
    }
}

