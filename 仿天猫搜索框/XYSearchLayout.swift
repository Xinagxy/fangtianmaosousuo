//
//  XYSearchLayout.swift
//  仿天猫搜索框
//
//  Created by 尧的mac on 16/8/18.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class XYSearchLayout: UICollectionViewFlowLayout {

    override func prepareLayout() {
        
        super.prepareLayout()
        
        //cell数据离头距离
        self.sectionInset = UIEdgeInsetsMake(15, 0, 0, 0);
        //每组头的大小
        self.headerReferenceSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 35);
        self.minimumInteritemSpacing = 15;
    }
    
    //这里就是返回每个cell，通过这里来调整位置
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        
       let arrCell =  super.layoutAttributesForElementsInRect(rect)
        
        for(var i = 1 ; i < arrCell?.count ; ++i){
        
            //当前 UICollectionViewLayoutAttributes
             let currentLayout = arrCell![i];
            //上一个 UICollectionViewLayoutAttributes
            let prevLayout = arrCell![i - 1];
            if (prevLayout.indexPath.section == currentLayout.indexPath.section) {
                //我们想设置的最大间距，可根据需要改
                let maximumSpacing = 15;
                //前一个cell的最右边
                let origin = CGRectGetMaxX(prevLayout.frame);
                //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
                //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
                if((CGFloat(origin) + CGFloat(maximumSpacing) + currentLayout.frame.size.width) < self.collectionViewContentSize().width) {
                    var frame = currentLayout.frame
                    frame.origin.x = CGFloat(origin) + CGFloat(maximumSpacing)
                    currentLayout.frame = frame
                }
            }
            
        }
        
        return arrCell
   
    }
    
}
