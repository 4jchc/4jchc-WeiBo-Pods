//
//  PhotoSelectorViewController.swift
//  WeiBo图片选择器
//
//  Created by 蒋进 on 16/2/12.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit


private let XMGPhotoSelectorCellReuseIdentifier = "XMGPhotoSelectorCellReuseIdentifier"
class PhotoSelectorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI()
    {
        // 1.添加子控件
        view.addSubview(collcetionView)
        
        // 2.布局子控件
        collcetionView.translatesAutoresizingMaskIntoConstraints = false
        var cons = [NSLayoutConstraint]()
        
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collcetionView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["collcetionView": collcetionView])
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[collcetionView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["collcetionView": collcetionView])
        view.addConstraints(cons)
        
    }
    // MARK: - 懒加载
    private lazy var collcetionView: UICollectionView = {
        let clv = UICollectionView(frame: CGRectZero, collectionViewLayout: PhotoSelectorViewLayout())
        clv.registerClass(PhotoSelectorCell.self, forCellWithReuseIdentifier: XMGPhotoSelectorCellReuseIdentifier)
        clv.dataSource = self
        return clv
    }()
    
    private lazy var pictureImages = [UIImage]()
    
}

extension PhotoSelectorViewController: UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return pictureImages.count
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collcetionView.dequeueReusableCellWithReuseIdentifier(XMGPhotoSelectorCellReuseIdentifier, forIndexPath: indexPath) as! PhotoSelectorCell
        
        cell.backgroundColor = UIColor.greenColor()
        
        return cell
    }
}

class PhotoSelectorCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI()
    {
        // 1.添加子控件
        contentView.addSubview(addButton)
        contentView.addSubview(removeButton)
        
        
        // 2.布局子控件
        addButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        var cons = [NSLayoutConstraint]()
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[addButton]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["addButton": addButton])
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[addButton]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["addButton": addButton])
        
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:[removeButton]-2-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["removeButton": removeButton])
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-2-[removeButton]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["removeButton": removeButton])
        
        contentView.addConstraints(cons)
    }
    
    // MARK: - 懒加载
    private lazy var removeButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "compose_photo_close"), forState: UIControlState.Normal)
        btn.addTarget(self, action: "removeBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    private lazy  var addButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "compose_pic_add"), forState: UIControlState.Normal)
        btn.addTarget(self, action: "addBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    func addBtnClick()
    {
        print(__FUNCTION__)
    }
    
    func removeBtnClick()
    {
        print(__FUNCTION__)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PhotoSelectorViewLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        
        itemSize = CGSize(width: 80, height: 80)
        minimumInteritemSpacing  = 10
        minimumLineSpacing = 10
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }
}
