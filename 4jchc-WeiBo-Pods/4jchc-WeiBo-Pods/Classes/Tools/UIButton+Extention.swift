

import UIKit
///*****✅重写UIButton的方法不用调用
class UIButtonTool: UIButton {
    
    
    
    //MARK: - ✅剪切图片的尺寸****改变图片的位置
    /// ✅剪切图片的尺寸****改变图片的位置
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        
        let imageW:CGFloat = 40;
        let imageH:CGFloat = 47;
        let imageX:CGFloat = (contentRect.size.width - imageW) * 0.5;
        let imageY:CGFloat = 20;
        
        return CGRectMake(imageX, imageY, imageW, imageH);
        
    }
    //        override var highlighted: Bool {
    //            get {
    //                return super.highlighted
    //
    //            }
    //            set {
    //                backgroundColor = UIColor(red: 0.27, green: 0.29, blue: 0.31, alpha: 1.0)
    //                //backgroundColor = UIColor.whiteColor()
    //                setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    //                println(tag)
    //                super.highlighted = newValue
    //            }
    //        }
    
    
    //MARK: - 没有高亮状态的按钮,重写setFrame方法
    /// 没有高亮状态的按钮,重写setFrame方法
    override var highlighted: Bool {
        
        didSet{
            super.highlighted = false
        }
    }
    
    //MARK: - 设置正常-高亮状态
    /// 设置正常-高亮状态
    func setNormal_Highlighted_BG(nbg:String, _ hbg:String){
        
        self.setBackgroundImage(UIImage(named: nbg), forState: UIControlState.Normal)
        self.setBackgroundImage(UIImage(named: hbg), forState: UIControlState.Highlighted)
        
    }
    
//    //MARK: - 设置正常-高亮拉升后状态
//    /// 设置正常-高亮拉升后状态
//    func setla拉升Normal_Highlighted_BG(nbg:String, _ hbg:String){
//        //用到uiimage的扩展方法
//        
//        self.setBackgroundImage(UIImage.imageWithStretchedName(nbg), forState: UIControlState.Normal)
//        self.setBackgroundImage(UIImage.imageWithStretchedName(hbg), forState: UIControlState.Highlighted)
//        
//    }
    
    
    func setTitleColor(color: UIColor?, forStates states: [UIControlState]) {
        for state in states {
            setTitleColor(color, forState: state)
        }
    }
    
    /**
     便利构造函数
     
     - parameter imageName:       图片名称
     - parameter backgroundImageName: 背景图片名称
     
     - returns: Button (图片-背景图片)
     */
    convenience init(Nor_Hig_Name: String, Nor_Hig_BG_Name: String){
        self.init()
        
        setImage(UIImage(named: Nor_Hig_Name), forState: UIControlState.Normal)
        setImage(UIImage(named: Nor_Hig_Name + "_highlighted"), forState: UIControlState.Highlighted)
        setBackgroundImage(UIImage(named: Nor_Hig_BG_Name), forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: Nor_Hig_BG_Name + "_highlighted"), forState: UIControlState.Highlighted)
        
        //根据图片 自动适应大小
        sizeToFit()
    }
    
    /**
     设置Button背景图片 便利构造函数
     
     - parameter title:      标题
     - parameter titleColor: 标题颜色
     - parameter backgroundImageName: 背景图片名称
     
     - returns:  Button(标题-背景图片)
     */
    convenience init(title: String, titleColor:UIColor, backgroundImageName:String) {
        self.init()
        
        setTitle(title, forState: .Normal)
        setTitleColor(titleColor, forState: .Normal)
        setBackgroundImage(UIImage(named: backgroundImageName), forState: .Normal)
        
    }
    
    /**
     设置Button图片 便利构造函数
     
     - parameter title:      标题
     - parameter titleColor: 标题颜色
     - parameter fontSize:   标题字体大小
     - parameter ImageName:  图片名称
     
     - returns: Button(标题-图片)
     */
    convenience init(title: String, titleColor:UIColor,fontSize: CGFloat, ImageName:String) {
        self.init()
        
        setTitle(title, forState: .Normal)
        setTitleColor(titleColor, forState: .Normal)
        setImage(UIImage(named: ImageName), forState: .Normal)
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
    
}






///*****✅Selected Highlighted图片一样 TouchUpInside就可以按钮只可以点一下
/* 设置按钮的图片
btn.setBackgroundImage(UIImage(named: imageName as String), forState: UIControlState.Normal)
btn.setBackgroundImage(UIImage(named: selImageName as String), forState: UIControlState.Selected)
btn.setBackgroundImage(UIImage(named: selImageName as String), forState: UIControlState.Highlighted)

/// 监听按钮的点击 TouchDown有弹簧可以连续点TouchUpInside只能点一次(重写uibutton)
//btn.addTarget(self, action: "btnClick:", forControlEvents: UIControlEvents.TouchDown)
btn.addTarget(self, action: "btnClick:", forControlEvents: UIControlEvents.TouchUpInside)
*/






//    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
//
//        let imageW:CGFloat = 30
//        let imageH:CGFloat = contentRect.size.height
//        let imageX:CGFloat = contentRect.size.width - imageW ;
//        let imageY:CGFloat = 0
//
//        return CGRectMake(imageX, imageY, imageW, imageH);
//
//    }
//
//
//    ///*****✅按钮图片的位置是剧中的
//    override func awakeFromNib() {
//
//        self.imageView!.contentMode = UIViewContentMode.Center
//    }
//
//
//
//    ////*****✅/ 不能使用self.titleLabel 因为self.titleLabel内部会调用titleRectForContentRect
//    ///*****✅改变文字的尺寸-----左边文字--右边图片
//    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
//
//        ///*****✅判断系统版本设置UINavigationBar导航条外观
//        let titleX:CGFloat = 0;
//        let titleY:CGFloat = 0;
//        var titleW:CGFloat = 0;
//
//        let size:CGSize = CGSizeMake(CGFloat.max, CGFloat.max)
//        let textDict:NSDictionary = [NSFontAttributeName: UIFont.systemFontOfSize(15)]
//
//
//        //***💗方法1
//        let os = NSProcessInfo().operatingSystemVersion
//
//        if (os.majorVersion > 7) {
//            ///*****✅计算字符的宽度 尺寸要与字体的相同
//            titleW = currentTitle!.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textDict as? [String : AnyObject], context: nil).size.width
//
//
//        }else{
//
//            titleW = self.currentTitle!.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(15)]).width
//
//
//        }
//
//        //***💗方法
//        //        let font:AnyObject = UIFont(name: "Helvetica Neue", size: 14.0) as! AnyObject
//        //        let name:NSObject = NSFontAttributeName as NSObject
//        //        let dict = [name:font]
//        //        let textSize: CGSize = text.sizeWithAttributes(dict)
//
//
//        let titleH:CGFloat = contentRect.size.height
//
//        return CGRectMake(titleX, titleY, titleW, titleH);
//    }



extension UIButton {
    
    
    //MARK: - 按钮--默认背景色
    ///  按钮--默认背景色
    class var defaultBackgroundColor : UIColor {
        
        get {
            
            return UIColor.orangeColor()
        }
    }
    
    //MARK: - 按钮--不可用背景色
    ///  按钮--不可用背景色
    class var enabledBackgroundColor : UIColor {
        
        get {
            
            return UIColor.lightGrayColor()
        }
    }
    
    
    //MARK: - 按钮--Border边框默认颜色
    ///  按钮--Border边框默认颜色
    class var defaultBorderColor : UIColor {
        
        get {
            
            return UIColor.orangeColor()
        }
    }
    //MARK: - 登录-按钮边框样式
    ///  登录-按钮边框样式
    func loginBorderStyle() {
        
        self.layer.borderColor = UIButton.defaultBorderColor.CGColor
        self.layer.borderWidth = 1.0
        self.backgroundColor = UIButton.defaultBackgroundColor
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    //MARK: - 登出-按钮边框样式
    ///  登出-按钮边框样式
    func loginNoBorderStyle() {
        
        self.backgroundColor = UIButton.defaultBackgroundColor
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    
}


extension UIButton {
    //MARK: - 按钮-统一背景&文字大小不同的图片和文字
    ///  按钮-统一背景不同的图片和文字
    class func createButton(imageName: String, title: String) -> UIButton{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setTitle(title, forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return btn
    }
    
    
}
