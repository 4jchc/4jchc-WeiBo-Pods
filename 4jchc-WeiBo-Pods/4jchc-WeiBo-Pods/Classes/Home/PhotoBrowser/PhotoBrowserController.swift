//
//  PhotoBrowserController.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/2/9.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
private let photoBrowserCellReuseIdentifier = "pictureCell"
class PhotoBrowserController: UIViewController {
    
    var currentIndex: Int?
    var pictureURLs: [NSURL]?
    init(index: Int, urls: [NSURL])
    {
        // Swift语法规定, 必须先初始化本类属性, 再初始化父类
        currentIndex = index
        pictureURLs = urls
        
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        // 初始化UI
        setupUI()
    }
    
    private func setupUI(){
        
        // 1.添加子控件
        view.addSubview(collectionView)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
        
        // 2.布局子控件
        closeBtn.xmg_AlignInner(type: XMG_AlignType.BottomLeft, referView: view, size: CGSize(width: 100, height: 35), offset: CGPoint(x: 10, y: -10))
        saveBtn.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: view, size: CGSize(width: 100, height: 35), offset: CGPoint(x: -10, y: -10))
        collectionView.frame = UIScreen.mainScreen().bounds
        
        // 3.设置数据源
        collectionView.dataSource = self
        collectionView.registerClass(PhotoBrowserCell.self, forCellWithReuseIdentifier: photoBrowserCellReuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func close()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func save()
    {
        print(__FUNCTION__)
    }
    
    // MARK: - 懒加载
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("关闭", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.darkGrayColor()
        
        btn.addTarget(self, action: "close", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    private lazy var saveBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("保存", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.darkGrayColor()
        
        btn.addTarget(self, action: "save", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    private lazy var collectionView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
}



extension PhotoBrowserController : UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(photoBrowserCellReuseIdentifier, forIndexPath: indexPath) as! PhotoBrowserCell
        
        cell.backgroundColor = UIColor.randomColor()
        cell.imageURL = pictureURLs![indexPath.item]
        
        return cell
    }
}

class PhotoBrowserLayout : UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        itemSize = UIScreen.mainScreen().bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        // 滚动Direction方向
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        // 显示Horizontal水平滚动Indicator指示器
        collectionView?.showsHorizontalScrollIndicator = false
        // 翻页效果
        collectionView?.pagingEnabled = true
        // 弹簧效果
        collectionView?.bounces =  false
    }
}












