//
//  XYSearchCell.swift
//  仿天猫搜索框
//
//  Created by 尧的mac on 16/8/18.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit


protocol SelectItemNameDelegate {
    
    func selectButttonClick(cell:XYSearchCell)
    
}

class XYSearchCell: UICollectionViewCell{

    @IBOutlet weak var titleBut: UIButton!
    var selectdelegate : SelectItemNameDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func titleNameBut(sender: AnyObject) {
        
//        if(self.selectdelegate.respondsToSelector("selectButttonClick: cell")){
        
            self.selectdelegate.selectButttonClick(self)
//        }
        
    }
  
    var itemModel: XYItemModel?{
        
        didSet{
        
            self.titleBut.setTitle(itemModel!.name!, forState: .Normal)
        }
        
    }
}
