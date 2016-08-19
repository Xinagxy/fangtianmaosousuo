//
//  XYReusableView.swift
//  仿天猫搜索框
//
//  Created by 尧的mac on 16/8/18.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class XYReusableView: UICollectionReusableView {

    @IBOutlet weak var imageView: UIImageView!
    

    
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    var searchModel: XYSearchModel?{
        
        didSet{
            
            self.title.text = searchModel!.title
            
        }
        
    }
    
    func setImage(imageStr:String){
        
        
        imageView.image = UIImage(named:imageStr)
    }
}
