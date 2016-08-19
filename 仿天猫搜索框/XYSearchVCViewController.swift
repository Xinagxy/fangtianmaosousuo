//
//  XYSearchVCViewController.swift
//  仿天猫搜索框
//
//  Created by 尧的mac on 16/8/18.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class XYSearchVCViewController: UIViewController
{

    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var flag:Int!
    
    var plistArr  =  NSMutableArray()
    
    //搜索的数据
    var searchArr  =  NSMutableArray()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.hidden = true
        view.backgroundColor = UIColor.whiteColor()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
      //数据
      setUpData()
        
        
        
        //设置布局
       collectionView.setCollectionViewLayout(XYSearchLayout(), animated: true)
        
       //加载cell
       collectionView.registerNib(UINib(nibName: "XYSearchCell", bundle: nil), forCellWithReuseIdentifier: "XYSearchCell")

       //加载cell的头部
        collectionView.registerNib(UINib(nibName: "XYReusableView",  bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader , withReuseIdentifier:"XYReusableView")
    
        
        
    }

    func setUpData(){
        //加载数据到数组
        let file =  NSBundle.mainBundle().pathForResource("假数据.plist", ofType: nil)! as String
        let fileArr =  NSDictionary(contentsOfFile: file)
        let seacrhModel =   XYSearchModel.mj_objectWithKeyValues(fileArr)
        plistArr.addObject(seacrhModel)
        
        
        //加载历史搜索数据
        let fileManager =   NSFileManager.defaultManager()
        if(fileManager.fileExistsAtPath(dataPath) ){
            let searcharrdict =  NSDictionary(contentsOfFile: dataPath)! as NSDictionary
            let seacrhModel1 =   XYSearchModel.mj_objectWithKeyValues(searcharrdict)
            if(seacrhModel1 != nil){
                plistArr.insertObject(seacrhModel1, atIndex: 0)
                //加载历史数据
                self.searchArr.addObjectsFromArray(searcharrdict["content"] as! [AnyObject])
                
            }
            print(dataPath)
        }
        
    }

    
    
    @IBAction func closeBut(sender: UIButton) {
        
        sender.selected = !sender.selected
        if(sender.selected){
            navigationController?.popViewControllerAnimated(true)
        }
        
    }
 
    
    
    @IBAction func searchBut(sender: AnyObject) {
        
        //字符为空
        if(searchText.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == ""){
            
            return
        }
        
        /*** 数据重复 */
        if (searchArr.containsObject(NSDictionary(object: searchText.text!, forKey: "name"))) {
            
            return
        }
        
        //每次将搜索的数据存储
        searchArr.addObject(NSDictionary(object: searchText.text!, forKey: "name"))
        //增加第二组数据，也就是历史数据,写入沙盒
        let searchDict = [
            "title":"最近搜索",
            "content":searchArr] as NSDictionary
        searchDict.writeToFile(dataPath, atomically: true)
        
        
        //始终保持只有两组
        if(plistArr.count>1){
            
            plistArr.removeObjectAtIndex(0)
        }
        
        let seacrhModel =   XYSearchModel.mj_objectWithKeyValues(searchDict)
        plistArr.insertObject(seacrhModel, atIndex: 0)
        
        
        //刷新
        self.collectionView.reloadData()
        self.searchText.text = ""

        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        searchText.becomeFirstResponder()
    }
    
    
}




extension XYSearchVCViewController: UICollectionViewDataSource,UICollectionViewDelegate ,SelectItemNameDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate{
    
    //MARK - UICollectionViewDelegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
         return plistArr.count;
    }
 
   //MARK - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      let seacrhModel =  plistArr[section] as? XYSearchModel
        
     return (seacrhModel?.content?.count)!;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
      let searchCell = collectionView.dequeueReusableCellWithReuseIdentifier("XYSearchCell", forIndexPath: indexPath) as? XYSearchCell
       
        let seacrhModel =  plistArr[indexPath.section] as? XYSearchModel
         //每组的数据
        let itemModel =  seacrhModel?.content![indexPath.row] as? XYItemModel
        
        searchCell!.itemModel = itemModel!
        
        
        searchCell!.selectdelegate = self;
        return searchCell!
    }
  
   
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var reusableView:UICollectionReusableView?
         //是每组的头
        if (kind == UICollectionElementKindSectionHeader){
            
           let searchReusable = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "XYReusableView", forIndexPath: indexPath) as? XYReusableView
          let seacrhModel =  plistArr[indexPath.section] as? XYSearchModel
           searchReusable?.searchModel = seacrhModel
            
            
            let flagdefults = YTdefaults.integerForKey("flag")
            if(flagdefults == 0){
                searchReusable?.setImage("cxCool")
                flag = 2
                YTdefaults.setInteger(flag, forKey: "flag")
                YTdefaults.synchronize()
            }else{
                
               if(indexPath.section == 0)
                 {
                  searchReusable?.setImage("cxSearch")
                
                 }else if(indexPath.section == 1){
                
                  searchReusable?.setImage("cxCool")
                 }
            }
           reusableView = searchReusable!
        }
        
        return reusableView!
    }
    
    
    //MARK - UICollectionViewDelegateFlowLayout  itme的大小
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
      
        let seacrhModel =  plistArr[indexPath.section] as? XYSearchModel
        if(seacrhModel?.content?.count > 0){
            
         let itemModel =  seacrhModel?.content![indexPath.row] as? XYItemModel
         let text = itemModel!.name! as NSString
         let size = text.boundingRectWithSize(CGSizeMake(CGFloat(MAXFLOAT), 24), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(12)], context: nil).size
           return CGSizeMake(size.width+20, 24)
        }
        
        return CGSizeMake(80, 24)

    }
    
    //MARK - 滚动就取消响应 只有scrollView的实际内容大于scrollView的尺寸时才会有滚动事件
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        searchText.resignFirstResponder()
        
    }

    
     //MARK - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //字符不为空
        if(textField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == ""){
        
          return false
        }

        /***  每搜索一次   就会存放一次到历史记录，但不存重复的 */
        if (searchArr.containsObject(NSDictionary(object: textField.text!, forKey: "name"))) {
        
            return true
        }
        
        //每次将搜索的数据存储
        searchArr.addObject(NSDictionary(object: textField.text!, forKey: "name"))
        //增加第二组数据，也就是历史数据,写入沙盒
       let searchDict = [
                        "title":"最近搜索",
                        "content":searchArr] as NSDictionary
        searchDict.writeToFile(dataPath, atomically: true)
        
        //始终保持只有两组
        if(plistArr.count>1){
            
            plistArr.removeObjectAtIndex(0)
        }
        let seacrhModel =   XYSearchModel.mj_objectWithKeyValues(searchDict)
        plistArr.insertObject(seacrhModel, atIndex: 0)

        //刷新
        self.collectionView.reloadData()
        self.searchText.text = ""
        
        return true
    }
    
    //MARK - SelectItemNameDelegate
    func selectButttonClick(cell:XYSearchCell){
        let indexPath =  self.collectionView.indexPathForCell(cell)
        let seacrhModel =  plistArr[indexPath!.section] as? XYSearchModel
        //每组的数据
        let itemModel =  seacrhModel?.content![indexPath!.row] as? XYItemModel
        
        
        let show = ShowNextViewController()
        show.setTexts((itemModel?.name)!)
        navigationController?.pushViewController(show, animated: true)
    
    }

    
}

