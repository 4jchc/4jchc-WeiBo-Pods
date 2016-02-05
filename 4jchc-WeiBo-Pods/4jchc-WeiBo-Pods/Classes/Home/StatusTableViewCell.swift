//
//  StatusTableViewCell.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/2/4.
//  Copyright © 2016年 蒋进. All rights reserved.
//



import UIKit
import SDWebImage

let XMGPictureViewCellReuseIdentifier = "XMGPictureViewCellReuseIdentifier"
class StatusTableViewCell: UITableViewCell {
    
    /// 保存配图的宽度约束
    var pictureWidthCons: NSLayoutConstraint?
    /// 保存配图的高度约束
    var pictureHeightCons: NSLayoutConstraint?
    
    var status: Status?
        {
        didSet{
            
            // 设置顶部视图
            topView.status = status
            
            // 设置正文
            contentLabel.text = status?.text
            
            // 设置配图的尺寸
            pictureView.status = status
            // 1.1根据模型计算配图的尺寸
            // 注意: 计算尺寸需要用到模型, 所以必须先传递模型
            let size = pictureView.calculateImageSize()
            // 1.2设置配图的尺寸
            pictureWidthCons?.constant = size.width
            pictureHeightCons?.constant = size.height
            
        }
    }
    
    
    // 自定义一个类需要重写的init方法是 designated
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 初始化UI
        setupUI()
    }
    
    private func setupUI()
    {
        // 1.添加子控件
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(pictureView)
        contentView.addSubview(footerView)
        
        let width = UIScreen.mainScreen().bounds.width
        // 2.布局子控件
        topView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: contentView, size: CGSize(width: width, height: 60))
        
        contentLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: topView, size: nil, offset: CGPoint(x: 10, y: 10))
        
        let cons = pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contentLabel, size: CGSizeZero, offset: CGPoint(x: 0, y: 10))
        
        pictureWidthCons = pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Width)
        pictureHeightCons =  pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Height)
        
        footerView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: pictureView, size: CGSize(width: width, height: 44), offset: CGPoint(x: -10, y: 10))
        
    }
    
    
    //MARK: - 用于获取行高
    ///  用于获取行高
    func rowHeight(status: Status) -> CGFloat
    {
        // 1.为了能够调用didSet, 计算配图的高度
        self.status = status
        
        // 2.强制更新界面
        self.layoutIfNeeded()
        
        // 3.返回底部视图最大的Y值
        return CGRectGetMaxY(footerView.frame)
    }
    // MARK: - 懒加载
    /// 顶部视图
    private lazy var topView: StatusTableViewTopView = StatusTableViewTopView()
    
    // MARK: 正文
    private lazy var contentLabel: UILabel =
    {
        let label = UILabel.createLabel(UIColor.darkGrayColor(), fontSize: 15)
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        return label
    }()
    
    // MARK: 配图
    private lazy var pictureView: StatusPictureView = StatusPictureView()
    
    // MARK: 底部工具条
    private lazy var footerView: StatusTableViewBottomView = StatusTableViewBottomView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}












//
//import UIKit
//import SDWebImage
//let XMGPictureViewCellReuseIdentifier = "XMGPictureViewCellReuseIdentifier"
//class StatusTableViewCell: UITableViewCell {
//
//    //MARK: - 保存配图的宽度约束
//    ///  保存配图的宽度约束
//    var pictureWidthCons: NSLayoutConstraint?
//    /// 保存配图的高度约束
//    var pictureHeightCons: NSLayoutConstraint?
//
//
//    var status: Status?  {
//        didSet{
//            //            textLabel?.text = status?.text
//            nameLabel.text = status?.user?.name
//
//            contentLabel.text = status?.text
//            // 设置用户头像
//            /*
//            if let iconURL = status?.user?.profile_image_url
//            {
//            let url = NSURL(string: iconURL)
//            iconView.sd_setImageWithURL(url)
//            }
//            */
//            if let url = status?.user?.imageURL
//            {
//                iconView.sd_setImageWithURL(url)
//            }
//            // 设置认证图标
//            verifiedView.image = status?.user?.verifiedImage
//            // 设置会员等级图标
//            vipView.image = status?.user?.mbrankImage
//            // 设置来源
//            sourceLabel.text = status?.source
//            // 设置时间
//            timeLabel.text = status?.created_at
//
//
//
//            // 设置配图的尺寸
//            // 1.1根据模型计算配图的尺寸
//            let size = calculateImageSize()
//            // 1.2设置配图的尺寸
//            pictureWidthCons?.constant = size.viewSize.width
//            pictureHeightCons?.constant = size.viewSize.height
//            // 1.3设置cell的大小
//            pictureLayout.itemSize = size.itemSize
//            // 1.4刷新表格
//            pictureView.reloadData()
//        }
//    }
//
//    // 自定义一个类需要重写的init方法是 designated
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        // 初始化UI
//        setupUI()
//
//        // 初始化配图
//        setupPictureView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupUI()
//    {
//        // 1.添加子控件
//        contentView.addSubview(iconView)
//        contentView.addSubview(verifiedView)
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(vipView)
//        contentView.addSubview(timeLabel)
//        contentView.addSubview(sourceLabel)
//        contentView.addSubview(contentLabel)
//        contentView.addSubview(footerView)
//        footerView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
//        contentView.addSubview(pictureView)
//
//        // 2.布局子控件
//        iconView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: contentView, size: CGSize(width: 50, height: 50), offset: CGPoint(x: 10, y: 10))
//        verifiedView.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: iconView, size: CGSize(width: 14, height: 14), offset: CGPoint(x:5, y:5))
//        nameLabel.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: iconView, size: nil, offset: CGPoint(x: 10, y: 0))
//        vipView.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: nameLabel, size: CGSize(width: 14, height: 14), offset: CGPoint(x: 10, y: 0))
//        timeLabel.xmg_AlignHorizontal(type: XMG_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 10, y: 0))
//        sourceLabel.xmg_AlignHorizontal(type: XMG_AlignType.BottomRight, referView: timeLabel, size: nil, offset: CGPoint(x: 10, y: 0))
//        contentLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: iconView, size: nil, offset: CGPoint(x: 0, y: 10))
//
//        let cons = pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contentLabel, size: CGSizeZero, offset: CGPoint(x: 0, y: 10))
//        //MARK: 获取自动布局Constraint约束的属性
//        pictureWidthCons = pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Width)
//        pictureHeightCons =  pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Height)
//        print("pictureWidthCons = \(pictureWidthCons)")
//        print("pictureHeightCons = \(pictureHeightCons)")
//
//        let width = UIScreen.mainScreen().bounds.width
//        footerView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: pictureView, size: CGSize(width: width, height: 44), offset: CGPoint(x: -10, y: 10))
//
//        // 添加一个底部约束
//        // TODO: 这个地方是又问题的
//        //        footerView.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: contentView, size: nil, offset: CGPoint(x: -10, y: -10))
//
//    }
//
//
//    //MARK: - 用于获取行高
//    ///  用于获取行高
//    func rowHeight(status: Status) -> CGFloat
//    {
//        // 1.为了能够调用didSet, 计算配图的高度
//        self.status = status
//
//        // 2.强制更新界面
//        self.layoutIfNeeded()
//
//        // 3.返回底部视图最大的Y值
//        return CGRectGetMaxY(footerView.frame)
//    }
//
//    //MARK:  计算配图的尺寸
//    ///  计算配图的尺寸
//    private func calculateImageSize() -> (viewSize: CGSize, itemSize: CGSize)
//    {
//        // 1.取出配图个数
//        let count = status?.storedPicURLS?.count
//        // 2.如果没有配图zero
//        if count == 0 || count == nil
//        {
//            return (CGSizeZero, CGSizeZero)
//        }
//        // 3.如果只有一张配图, 返回图片的实际大小
//        if count == 1
//        {
//            // 3.1取出缓存的图片
//            let key = status?.storedPicURLS!.first?.absoluteString
//            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key!)
//
//            //            pictureLayout.itemSize = image.size
//            // 3.2返回缓存图片的尺寸
//            return (image.size, image.size)
//        }
//        // 4.如果有4张配图, 计算田字格的大小
//        let width = 90
//        let margin = 10
//        //        pictureLayout.itemSize = CGSize(width: width, height: width)
//
//        if count == 4
//        {
//            let viewWidth = width * 2 + margin
//            return (CGSize(width: viewWidth, height: viewWidth), CGSize(width: width, height: width))
//        }
//
//        // 5.如果是其它(多张), 计算九宫格的大小
//        /*
//        2/3
//        5/6
//        7/8/9
//        */
//        // 5.1计算列数
//        let colNumber = 3
//        // 5.2计算行数
//        //               (8 - 1) / 3 + 1
//        let rowNumber = (count! - 1) / 3 + 1
//        // 宽度 = 列数 * 图片的宽度 + (列数 - 1) * 间隙
//        let viewWidth = colNumber * width + (colNumber - 1) * margin
//        // 高度 = 行数 * 图片的高度 + (行数 - 1) * 间隙
//        let viewHeight = rowNumber * width + (rowNumber - 1) * margin
//        return (CGSize(width: viewWidth, height: viewHeight), CGSize(width: width, height: width))
//
//    }
//
//    //MARK:  初始化配图的相关属性
//    ///  初始化配图的相关属性
//    private func setupPictureView()
//    {
//        // 1.注册cell
//        pictureView.registerClass(PictureViewCell.self, forCellWithReuseIdentifier: XMGPictureViewCellReuseIdentifier)
//
//        // 2.设置数据源
//        pictureView.dataSource = self
//
//        // 2.设置cell之间的间隙
//        pictureLayout.minimumInteritemSpacing = 10
//        pictureLayout.minimumLineSpacing = 10
//
//        // 3.设置配图的背景颜色
//        pictureView.backgroundColor = UIColor.darkGrayColor()
//    }
//
//
//    // MARK:  懒加载
//    /// 头像
//    private lazy var iconView: UIImageView =
//    {
//        let iv = UIImageView(image: UIImage(named: "avatar_default_big"))
//        return iv
//    }()
//    /// 认证图标
//    private lazy var verifiedView: UIImageView = UIImageView(image: UIImage(named: ""))
//
//    /// 昵称
//    private lazy var nameLabel: UILabel = UILabel.createLabel(UIColor.darkGrayColor(), fontSize: 14)
//
//    /// 会员图标
//    private lazy var vipView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
//
//    /// 时间
//    private lazy var timeLabel: UILabel = UILabel.createLabel(UIColor.darkGrayColor(), fontSize: 14)
//    /// 来源
//    private lazy var sourceLabel: UILabel = UILabel.createLabel(UIColor.darkGrayColor(), fontSize: 14)
//
//    /// 正文
//    private lazy var contentLabel: UILabel =
//    {
//        let label = UILabel.createLabel(UIColor.darkGrayColor(), fontSize: 15)
//        label.numberOfLines = 0
//        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
//        return label
//    }()
//
//
//    //MARK:   配图
//    private lazy var pictureLayout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
//    private lazy var pictureView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.pictureLayout)
//
//
//
//    /// 底部工具条
//    private lazy var footerView: StatusFooterView = StatusFooterView()
//
//}
//
//class StatusFooterView: UIView {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        // 初始化UI
//        setupUI()
//    }
//
//
//    private func setupUI()
//    {
//        // 1.添加子控件
//        addSubview(retweetBtn)
//        addSubview(unlikeBtn)
//        addSubview(commonBtn)
//
//        // 2.布局子控件
//        xmg_HorizontalTile([retweetBtn, unlikeBtn, commonBtn], insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
//    }
//
//
//    // MARK:  懒加载
//    // 转发
//    private lazy var retweetBtn: UIButton = UIButton.createButton("timeline_icon_retweet", title: "转发")
//
//    // 赞
//    private lazy var unlikeBtn: UIButton = UIButton.createButton("timeline_icon_unlike", title: "赞")
//
//    // 评论
//    private lazy var commonBtn: UIButton = UIButton.createButton("timeline_icon_comment", title: "评论")
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
////MARK: - 数据源方法
//extension StatusTableViewCell: UICollectionViewDataSource {
//
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return status?.storedPicURLS?.count ?? 0
//    }
//
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        // 1.取出cell
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(XMGPictureViewCellReuseIdentifier, forIndexPath: indexPath) as! PictureViewCell
//        // 2.设置数据
//        //        cell.backgroundColor = UIColor.greenColor()
//        cell.imageURL = status?.storedPicURLS![indexPath.item]
//        // 3.返回cell
//        return cell
//    }
//}
//
//
//
//
////MARK: - 自定义UICollectionViewCell
//class PictureViewCell: UICollectionViewCell {
//
//    // 定义属性接收外界传入的数据
//    var imageURL: NSURL?
//        {
//        didSet{
//            iconImageView.sd_setImageWithURL(imageURL!)
//        }
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        // 初始化UI
//        setupUI()
//    }
//
//    private func setupUI()
//    {
//        // 1.添加子控件
//        contentView.addSubview(iconImageView)
//        // 2.布局子控件
//        iconImageView.xmg_Fill(contentView)
//    }
//
//    // MARK:  懒加载
//    private lazy var iconImageView:UIImageView = UIImageView()
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}



