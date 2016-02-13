//
//  StatusForwardTableViewCell.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/2/6.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
//Status状态 Forward 转送 TableViewCell
class StatusForwardTableViewCell: StatusTableViewCell {
    
    
    // 重写父类属性的didSet并不会覆盖父类的操作
    // 只需要在重写方法中, 做自己想做的事即可
    // 注意点: 如果父类是didSet, 那么子类重写也只能重写didSet
    override var status: Status?
        {
        didSet{
            let name = status?.retweeted_status?.user?.name ?? ""
            let text = status?.retweeted_status?.text ?? ""
            //forwardLabel.text = name + ": " + text
            // 图文混排
            forwardLabel.attributedText = EmoticonPackage.emoticonString(name + ": " + text)
        }
    }
    
    
    
    override func setupUI() {
        super.setupUI()
        
        // 1.添加子控件
        //        contentView.addSubview(forwardButton)
        contentView.insertSubview(forwardButton, belowSubview: pictureView)
        contentView.insertSubview(forwardLabel, aboveSubview: forwardButton)
        
        // 2.布局子控件
        
        // 2.1布局转发背景
        forwardButton.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contentLabel, size: nil, offset: CGPoint(x: -10, y: 10))
        forwardButton.xmg_AlignVertical(type: XMG_AlignType.TopRight, referView: footerView, size: nil)
        
        // 2.2布局转发正文
        forwardLabel.text = "fjdskljflkdsjflksdjlkfdsjlfjdslfjlkds"
        forwardLabel.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: forwardButton, size: nil, offset: CGPoint(x: 10, y: 10))
        
        // 2.3重新调整转发配图的位置
        let cons = pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: forwardLabel, size: CGSize(width: 290, height: 290), offset: CGPoint(x: 0, y: 10))
        
        pictureWidthCons = pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Width)
        pictureHeightCons =  pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Height)
        pictureTopCons = pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Top)
        
    }
    
    // MARK: - 懒加载
    private lazy var forwardLabel: UILabel = {
        let label = UILabel.createLabel(UIColor.darkGrayColor(), fontSize: 15)
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        return label
    }()
    
    private lazy var forwardButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        return btn
    }()
}


