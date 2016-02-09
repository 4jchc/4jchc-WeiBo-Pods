//
//  HomeViewController.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/1/27.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
let XMGHomeReuseIdentifier = "XMGHomeReuseIdentifier"

class HomeTableViewController: BaseTableViewController {
    
    /// 保存微博数组
    var statuses: [Status]?{
        didSet{
            // 当别人设置完毕数据, 就刷新表格
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.如果没有登录, 就设置未登录界面的信息
        if !userLogin
        {
            visitorView?.setupVisitorInfo(true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        // 2.初始化导航条
        setupNav()
        
        // 3.注册通知, 监听菜单
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "change", name: XMGPopoverAnimatorWillShow, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "change", name: XMGPopoverAnimatorWilldismiss, object: nil)
        
        // 注册一个cell
        //tableView.registerClass(StatusNormalTableViewCell.self, forCellReuseIdentifier: XMGHomeReuseIdentifier)
        //        tableView.rowHeight = 200 estimated--估计的 RowHeight
        
        // 注册两个cell
        tableView.registerClass(StatusNormalTableViewCell.self, forCellReuseIdentifier: StatusTableViewCellIdentifier.NormalCell.rawValue)
        tableView.registerClass(StatusForwardTableViewCell.self, forCellReuseIdentifier: StatusTableViewCellIdentifier.ForwardCell.rawValue)
        
        tableView.estimatedRowHeight = 200
        //tableView.rowHeight = UITableView Automatic Dimension尺寸
        tableView.rowHeight = 300
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // 4.添加下拉刷新控件
        //MARK: 系统刷新控件3句话
//        refreshControl = UIRefreshControl()
//        refreshControl!.attributedTitle = NSAttributedString(string: "松手刷新")
//        refreshControl?.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)

        
        //MARK:  自定义刷新控件
        refreshControl = HomeRefreshControl()
        refreshControl?.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        // 4.加载微博数据
        loadData()
    }
    
    deinit
    {
        // 移除通知
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK:  定义变量记录当前是上拉还是下拉
    var pullupRefreshFlag = false
    
    /**
     获取微博数据
     如果想调用一个私有的方法:
     1.去掉private
     2.@objc, 当做OC方法来处理
     */
    //MARK: - 获取微博数据
    ///  获取微博数据
    @objc private func loadData()
    {
        /*
        1.默认最新返回20条数据
        2.since_id : 会返回比since_id大的微博
        3.max_id: 会返回小于等于max_id的微博
        
        每条微博都有一个微博ID, 而且微博ID越后面发送的微博, 它的微博ID越大
        递增
        
        新浪返回给我们的微博数据, 是从大到小的返回给我们的

        */
        var since_id = statuses?.first?.id ?? 0
        
        
        var max_id = 0
        //MARK:  2.判断是否是上拉
        if pullupRefreshFlag
        {
            since_id = 0
            max_id = statuses?.last?.id ?? 0
        }
        
        printLog("statuses?.first?.id=\(statuses?.first?.id) statuses?.last?.id=\(statuses?.last?.id)")
        
        Status.loadStatuses(since_id,max_id: max_id) { (models, error) -> () in
            
            printLog("since_id--max_id\(since_id)-\(max_id)")
            // 接收刷新
            self.refreshControl?.endRefreshing()
            if error != nil
            {
                printLog("Status.loadStatuses加载数据失败\(error)")
                return
            }
            // 下拉刷新
            if since_id > 0
            {
                // 如果是下拉刷新, 就将获取到的数据, 拼接在原有数据的前面
                self.statuses = models! + self.statuses!
                
                // 显示刷新提醒
                self.showNewStatusCount(models?.count ?? 0)
            //上拉刷新
            }else if max_id > 0
            {
                // 如果是上拉加载更多, 就将获取到的数据, 拼接在原有数据的后面
                self.statuses = self.statuses! + models!
            }
            else
            {
                self.statuses = models
            }
        }
    }
    
    //MARK:  显示刷新提醒--动画
    ///  显示刷新提醒动画
    private func showNewStatusCount(count : Int)
    {
        newStatusLabel.hidden = false
        newStatusLabel.text = (count == 0) ? "没有刷新到新的微博数据" : "刷新到\(count)条微博数据"
        /*
        // 1.记录提醒控件的frame
        let rect = newStatusLabel.frame
        // 2.执行动画
        UIView.animateWithDuration(2, animations: { () -> Void in
        // 3.设置动画自动reverses翻转
        UIView.setAnimationRepeatAutoreverses(true)
        self.newStatusLabel.frame = CGRectOffset(rect, 0, 3 * rect.height)
        
        }) { (_) -> Void in
        self.newStatusLabel.frame = rect
        }
        */
        // 2秒向下移动2秒还原然后隐藏 x轴移动0.Y轴移动视图的高度

        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 12, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            
            self.newStatusLabel.transform = CGAffineTransformMakeTranslation(0, self.newStatusLabel.frame.height+100.0)
            self.newStatusLabel.transform = CGAffineTransformScale(self.newStatusLabel.transform, 0.7, 0.7);
            }) { (_) -> Void in
                
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.newStatusLabel.transform = CGAffineTransformIdentity
                    }, completion: { (_) -> Void in
                        self.newStatusLabel.hidden = true
                })
        }
        
        
    }
    
    ///修改标题按钮的状态
    func change(){
        
        // 1.修改标题按钮的状态
        let titleBtn = navigationItem.titleView as! TitleButton
        titleBtn.selected = !titleBtn.selected
    }
    
    
    private func setupNav(){
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_friendattention", target: self, action: "leftItemClick")
        //navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_pop", target: self, action: "rightItemClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image_Nor_Hig_name: "navigationbar_pop", target: self, action: "rightItemClick")
        
        // 2.初始化标题按钮
        let titleBtn = TitleButton()
        titleBtn.setTitle("4jchc ", forState: UIControlState.Normal)
        titleBtn.addTarget(self, action: "titleBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.titleView = titleBtn
    }
    
    func titleBtnClick(btn: TitleButton)
    {
        
        
        // 2.弹出菜单
        let sb = UIStoryboard(name: "PopoverViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        // 2.1设置转场代理
        // 默认情况下modal会移除以前控制器的view, 替换为当前弹出的view
        // 如果自定义转场, 那么就不会移除以前控制器的view
        
        //vc?.transitioningDelegate = self 💗封装转场代理
        
        vc?.transitioningDelegate = popverAnimator
        // 2.2设置转场的样式
        vc?.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        presentViewController(vc!, animated: true, completion: nil)
        
    }
    
    func leftItemClick()
    {
        printLog(__FUNCTION__)
    }
    
    func rightItemClick()
    {
        
        let sb = UIStoryboard(name: "QRCodeViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        presentViewController(vc!, animated: true, completion: nil)
    }
    
    // MARK: - 懒加载  封装转场代理
    // 一定要定义一个属性来保存自定义转场对象, 否则会报错
    private lazy var popverAnimator:PopoverAnimator = {
        let pa = PopoverAnimator()
        pa.presentFrame = CGRect(x: 100, y: 56, width: 200, height: 350)
        return pa
    }()
    
    // MARK: 刷新提醒控件
    private lazy var newStatusLabel: UILabel =
    {
        let label = UILabel()
        let height: CGFloat = 44
        //label.frame =  CGRect(x: 0, y: -2 * height, width: UIScreen.mainScreen().bounds.width, height: height)
        label.frame =  CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: height)
        
        label.backgroundColor = UIColor.orangeColor()
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        
        // 加载lable插入navBar 上面，不然会随着 tableView 一起滚动
        self.navigationController?.navigationBar.insertSubview(label, atIndex: 0)
        
        label.hidden = true
        return label
    }()
    
    // MARK: 微博行高的缓存, 利用字典作为容器. key就是微博的id, 值就是对应微博的行高
    var rowCache: [Int: CGFloat] = [Int: CGFloat]()
    //MARK: 内存警告
    override func didReceiveMemoryWarning() {
        // 清空缓存
        rowCache.removeAll()
    }
    
    
}


extension HomeTableViewController{
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return statuses?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 1.获取cell
        //let cell = tableView.dequeueReusableCellWithIdentifier(XMGHomeReuseIdentifier, forIndexPath: indexPath) as! StatusTableViewCell

        // 2.设置数据
        let status = statuses![indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(StatusTableViewCellIdentifier.cellID(status)) as! StatusTableViewCell
        // cell.textLabel?.text = status.text
        cell.status = status
        
        // 4.判断是否滚动到了最后一个cell---做一个标记
        let count = statuses?.count ?? 0
        if indexPath.row == (count - 1)
        {
            pullupRefreshFlag = true
            printLog("上拉加载更多")
            loadData()
        }
        
        // 3.返回cell
        return cell
    }
    
    // 返回行高
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // 1.取出对应行的模型
        let status = statuses![indexPath.row]
        
        // 2.判断缓存中有没有
        if let height = rowCache[status.id]
        {
            printLog("从缓存中获取")
            return height
        }
        
        // 3.拿到cell
        //let cell = tableView.dequeueReusableCellWithIdentifier(XMGHomeReuseIdentifier) as! StatusTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier(StatusTableViewCellIdentifier.cellID(status)) as! StatusTableViewCell
        // 注意点:不要使用以下方法获取, 在某些版本或者模拟器会有bug
        //        tableView.dequeueReusableCellWithIdentifier(<#T##identifier: String##String#>, forIndexPath: <#T##NSIndexPath#>)
        
        // 4.拿到对应行的行高
        let rowHeight = cell.rowHeight(status)
        
        // 5.缓存行高
        rowCache[status.id] = rowHeight
        printLog("重新计算")
        
        // 6.返回行高
        return rowHeight
    }
    
    // 预估行高，可以提高性能
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    
}







