
//
//  commond.swift
//  仿天猫搜索框
//
//  Created by 尧的mac on 16/8/19.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import Foundation

let Domains =  NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
    NSSearchPathDomainMask.UserDomainMask, true)
let path = Domains[0] as NSString
let dataPath = path.stringByAppendingPathComponent("search.plist")



let  YTdefaults =  NSUserDefaults.standardUserDefaults() as NSUserDefaults