//
//  WeiBo图片选择器-开发笔记.swift
//  WeiBo图片选择器
//
//  Created by 蒋进 on 16/2/12.
//  Copyright © 2016年 蒋进. All rights reserved.
//


    /*
    //MARK: 1 布局图片选择器界面
    1.VFL的使用
    2.collocation的强化学习
    */

    /*
    //MARK: 2 显示图片
    1.父子关系使用代理
     设置允许用户编辑选中的图片
     开发中如果需要上传头像, 那么请让用户编辑之后再上传
     这样可以得到一张正方形的图片, 以便于后期处理(圆形)
     vc.allowsEditing = true
    2.照片选择器必须要遵守UINavigationControllerDelegate,UIImagePickerControllerDelegate

    3.case PhotoLibrary 照片库(所有的照片，拍照&用 iTunes & iPhoto `同步`的照片 - 不能删除)
     case SavedPhotosAlbum 相册 (自己拍照保存的, 可以随便删除)
     case Camera    相机
    4.判断能否打开照片库
     !UIImagePickerController.isSourceTypeAvailable( UIImagePickerControllerSourceType.PhotoLibrary)
    5.图片的个数判断---本身cell就有一个图片
     cell.image = (pictureImages.count == indexPath.item) ? nil : pictureImages[indexPath.item]
    6.自定义cell的image.有值隐藏加号图片设置本地图片删除按钮显示.可以交互yes
    */

    /*
    图片浏览器内存问题
    0. 一般情况下,只要涉及到从相册中获取图片的功能, 都需要处理内存
    一般情况下一个应用程序启动会占用20M左右的内存, 当内存飙升到500M左右的时候系统就会发送内存警告, 此时就需要释放内存 , 否则就会闪退
    只要内存释放到100M左右, 那么系统就不会闪退我们的应用程序
    也就是说一个应用程序占用的内存20~100时是比较安全的内容范围
    1. 图片压缩自定义Uiimage扩展
    2. layer模式默认是填充的
    3. 如果是通过JPEG来压缩图片, 图片压缩之后是不保真的
     苹果官方不推荐我们使用JPG图片,因为现实JPG图片的时候解压缩非常消耗性能
    let data1 = UIImageJPEG Representation显示(image, 1.0)
    4. 注意: 如果实现了该方法, 需要我们自己关闭图片选择器
    picker.dismissViewControllerAnimated(true, completion: nil)
    */


//MARK: - 开始💗

/*

class ViewController1: UIViewController {

weak var customTextView: UITextView!


override func viewDidLoad() {
super.viewDidLoad()

// 1.将键盘控制器添加为当前控制器的子控制器
addChildViewController(emoticonVC)

// 2.将表情键盘控制器的view设置为UITextView的inputView
customTextView.inputView = emoticonVC.view
// 初始化UI
setupUI()
}

//MARK:  初始化UI
///  初始化UI
private func setupUI(){

// 1.添加子控件

view.addSubview(<#collectionVeiw#>)
view.addSubview(<#collectionVeiw#>)

// 2.布局子控件

<#setupConstraint()#>
}
//MARK:  纯代码设置约束
func setupConstraint(){

//使用Auto Layout的方式来布局
button.translatesAutoresizingMaskIntoConstraints = false
textField.translatesAutoresizingMaskIntoConstraints = false
textView.translatesAutoresizingMaskIntoConstraints = false


// 创建一个约束数组
var cons = [NSLayoutConstraint]()
// 创建一个控件数组
let dict = ["collectionVeiw": collectionVeiw, "toolbar": toolbar]

//创建一个水平居中约束（按钮）
cons += NSLayoutConstraint(
item: button, attribute: .CenterX, relatedBy: .Equal,
toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
//创建水平方向约束
cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionVeiw]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[toolbar]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
//创建垂直方向约束
cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[collectionVeiw]-[toolbar(44)]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)

view.addConstraints(cons)


}


// MARK: - 懒加载
private lazy var emoticonVC = <#collectionVeiw#>()


}

*/

//MARK: - 结束💗