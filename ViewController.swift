//
//  ViewController.swift
//  CustomerIOIntegration
//
//  Created by Ravi Shankar on 16/04/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK:- Setup Customer Data
    
    @IBAction func customerSignUp(sender: UIButton) {
        
        let data = ["email":"customer@example.com","name":"Bob","plan":"premium","location":"Chennai"]
        CustomerIOWrapper().createCustomer(4, data: data)
    }
    
    
    @IBAction func sendEvent(sender: UIButton) {
        let data = ["name":"upgrade","visit":"3"]
        CustomerIOWrapper().sendEvent(4, data: data)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

