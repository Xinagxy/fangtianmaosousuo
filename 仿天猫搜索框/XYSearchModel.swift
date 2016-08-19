//
//  XYSearchModel.swift
//  仿天猫搜索框
//
//  Created by 尧的mac on 16/8/18.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class XYSearchModel: NSObject {

    
    
    /** id */
    var id: String?
    /** 组标题 */
    var title: String?

    
    /** 数据 */
    var content: NSMutableArray?
    
    //数组存储的是模型数据
    override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        
        return [
            "content" : XYItemModel.self
        ]
    }

}
