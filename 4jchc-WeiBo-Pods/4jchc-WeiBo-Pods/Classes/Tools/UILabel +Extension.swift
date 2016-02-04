

import UIKit
import Foundation

public extension UILabel {
    
    

    //MARK: - 快速创建一个UILabel
    ///  快速创建一个UILabel
    class func createLabel(color: UIColor, fontSize: CGFloat) -> UILabel
    {
        let label = UILabel()
        label.textColor = color
        label.font = UIFont.systemFontOfSize(fontSize)
        return label
    }
    
    
    
    
    
    public class func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    //MARK: - 文字-内容-颜色-字体-相对与屏幕两边的偏移量
    
    /**
    文字-内容-颜色-字体-相对与屏幕两边的偏移量
    
    - parameter title:       文字内容
    - parameter txtColor:    文字颜色
    - parameter fontSize:    字的字体大小
    - parameter screenInset: 相对与屏幕两边的偏移量
    
    - returns: Title
    */
    convenience init(title:String, txtColor:UIColor = UIColor.darkGrayColor(), fontSize:CGFloat = 14, screenInset: CGFloat = 0){
        self.init()
        
        text = title;
        textColor = txtColor
        font = UIFont.systemFontOfSize(fontSize)
        numberOfLines = 0
        
        if screenInset == 0 {
            textAlignment = .Center
        } else {
            // 设置换行宽度
            preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 2 * screenInset
            textAlignment = .Left
        }
    }
    
    
    
    
    
    
    
    
    
}








