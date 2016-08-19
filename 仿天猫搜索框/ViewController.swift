//
//  ViewController.swift
//  仿天猫搜索框
//
//  Created by 尧的mac on 16/8/18.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func nextSearchBut(sender: AnyObject) {
        
        
      navigationController?.pushViewController(XYSearchVCViewController(), animated: true)
        
    }
}

