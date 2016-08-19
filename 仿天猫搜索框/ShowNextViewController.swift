//
//  ShowNextViewController.swift
//  仿天猫搜索框
//
//  Created by 尧的mac on 16/8/19.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class ShowNextViewController: UIViewController {

    
    @IBOutlet weak var text: UILabel!

    var textTemp:String!
    override func viewDidLoad() {
              super.viewDidLoad()

        navigationController?.navigationBar.hidden = false 
        text.text = textTemp

        print("viewDidLoad+\(text.text)")
    }

    func setTexts(texts: String){
        
        textTemp = texts
        
         print("setTexts+")

        
    }


}
