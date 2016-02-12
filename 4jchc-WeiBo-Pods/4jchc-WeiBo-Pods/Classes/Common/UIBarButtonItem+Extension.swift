

import Foundation
import UIKit
extension UIBarButtonItem{
    
    /*
    
    //MARK:  快速创建UIButton类型的按钮(图片正常--高亮状态)
    ///  快速创建UIButton类型的按钮(图片正常--高亮状态)
    class func creatBarButtonItem(imageName:String, target: AnyObject?, action:Selector?) ->UIBarButtonItem {
    let btn = UIButton()
    btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
    btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
    btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    btn.sizeToFit()
    return UIBarButtonItem(customView: btn)
    }

    */

    //MARK:  快速创建UIButton类型的按钮(图片正常--高亮状态)
    ///  快速创建UIButton类型的按钮(图片正常--高亮状态)
    class func creatBarButtonItem(imageName:String, target: AnyObject?, action:String?) ->UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        if action != nil
        {
            // 如果是自己封装一个按钮, 最好传入字符串, 然后再将字符串包装为Selector
            btn.addTarget(target, action: Selector(action!), forControlEvents: UIControlEvents.TouchUpInside)
        }
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
    }
    //MARK: - init方法中的action为string类型
    ///  init方法中的action为string类型
    convenience init(imageName:String, target: AnyObject?, action: String?)
    {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        if action != nil
        {
            // 如果是自己封装一个按钮, 最好传入字符串, 然后再将字符串包装为Selector
            btn.addTarget(target, action: Selector(action!), forControlEvents: UIControlEvents.TouchUpInside)
        }
        btn.sizeToFit()
        self.init(customView: btn)
    }
    

    //给 UIBarButtonItem分类添加一个方法 返回一个 UIBarButtonItem对象
    class func ItemWithTitleImageTarget(image_Nor_Hig_Name: String = "", title: String = "", target: AnyObject?, action: Selector)->UIBarButtonItem {
        //创建一个 button
        let button = UIButton()
        //添加点击事件
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        //添加图片
        if image_Nor_Hig_Name.characters.count > 0 {
            button.setImage(UIImage(named: image_Nor_Hig_Name), forState: UIControlState.Normal)
            button.setImage(UIImage(named: "\(image_Nor_Hig_Name)_highlighted"), forState: UIControlState.Highlighted)
        }
        
        //添加字体
        if title.characters.count > 0 {
            button.setTitle(title, forState: UIControlState.Normal)
            
            //设置字体大小
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            
            //设置字体颜色
            button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Highlighted)
        }
        
        //调整一下
        button.sizeToFit()
        
        return UIBarButtonItem(customView: button)
    }

    /**
     *  创建一个item
     *  @param target    点击item后调用哪个对象的方法
     *  @param action    点击item后调用target的哪个方法
     *  @param image     图片
     *  @param highImage 高亮的图片
     *  @return 创建完的item
     */ //ItemWithImageTarget
    class func ItemWithImageTarget(target:AnyObject?,action:Selector,image:String,hightImage:String) ->UIBarButtonItem{
        
        let btn:UIButton = UIButton(type: UIButtonType.Custom)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        // 设置图片
        btn.setBackgroundImage(UIImage(named: image ), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: hightImage ), forState: UIControlState.Highlighted)
        
        // 设置尺寸
        btn.frame.size = btn.currentBackgroundImage!.size;
        
        return UIBarButtonItem(customView: btn)
        
    }
    //MARK: - init方法
    convenience init(imageName: String?, highlightedImageName: String?, title: String?, target: AnyObject?, action: Selector) {
        
        let button = UIButton()
        if let imageName = imageName, highlightedImageName = highlightedImageName {
            button.setBackgroundImage(UIImage(named: imageName), forState: .Normal)
            button.setBackgroundImage(UIImage(named: highlightedImageName), forState: .Highlighted)
        }
        button.sizeToFit()
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        
        self.init(customView: button)
    }
    
    convenience init(title: String, target: AnyObject?, action: Selector) {
        self.init(imageName: nil, highlightedImageName: nil, title: title, target: target, action: action)
    }
    
    
    
    
    
    
    convenience init(image_Nor_Hig_name:String, target: AnyObject?, action: String?)
    {
        let btn = UIButton()
        btn.setImage(UIImage(named: image_Nor_Hig_name), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: image_Nor_Hig_name + "_highlighted"), forState: UIControlState.Highlighted)
        if action != nil
        {
            // 如果是自己封装一个按钮, 最好传入字符串, 然后再将字符串包装为Selector
            btn.addTarget(target, action: Selector(action!), forControlEvents: UIControlEvents.TouchUpInside)
        }
        btn.sizeToFit()
        self.init(customView: btn)
    }
    
    convenience init(imageName: String, highlightedImageName: String, target: AnyObject?, action: Selector) {
        self.init(imageName: imageName, highlightedImageName: highlightedImageName, title: nil, target: target, action: action)
    }
    
    
    
    
}