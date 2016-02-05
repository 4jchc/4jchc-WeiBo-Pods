//
//  NSDate+Extension.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/11/30.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit


//MARK: - 微博版时间设置
extension NSDate{
    
    
     //MARK: - 判断是否为- 今年
     ///  判断是否为- 今年
    func isThisYear()->Bool{
        let calendar: NSCalendar  = NSCalendar.currentCalendar()
        // 获得的年月日时分秒
        let dateCmps: NSDateComponents  = calendar.components(NSCalendarUnit.Year, fromDate:self.dynamicType.init())
        
        let nowCmps: NSDateComponents  = calendar.components(NSCalendarUnit.Year, fromDate: NSDate())
        
        return dateCmps.year == nowCmps.year;
    }
    

     //MARK: - 判断是否为- 昨天
     ///  判断是否为- 昨天
    func isYesterday() ->Bool{
        var now: NSDate  = NSDate()
        
        // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
        // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
        let fmt: NSDateFormatter = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd";
        
        // 2014-04-30
        let dateStr: NSString  = fmt.stringFromDate(self)
        // 2014-10-18
        let nowStr: NSString  = fmt.stringFromDate(now)
        
        
        // 2014-10-30 00:00:00
        let date: NSDate = fmt.dateFromString(dateStr as String)!
        // 2014-10-18 00:00:00
        now = fmt.dateFromString(nowStr as String)!
        
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        
        let unit: NSCalendarUnit = [NSCalendarUnit.Year , NSCalendarUnit.Month , NSCalendarUnit.Day]
        
        let cmps: NSDateComponents  = calendar.components(unit, fromDate: date, toDate: now, options: NSCalendarOptions())
        
        
        return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
    }
    

     //MARK: - 判断是否为- 今天
     ///  判断是否为- 今天
    func isToday()->Bool
    {
        let now: NSDate  = NSDate()
        let fmt: NSDateFormatter  = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd";
        // 2014-04-30
        let dateStr: NSString  = fmt.stringFromDate(self)
        // 2014-10-18
        let nowStr: NSString  = fmt.stringFromDate(now)
        
        
        return dateStr.isEqualToString(nowStr as String)
    }
    
    

    /**
     刚刚(一分钟内)
     X分钟前(一小时内)
     X小时前(当天)
     昨天 HH:mm(昨天)
     MM-dd HH:mm(一年内)
     yyyy-MM-dd HH:mm(更早期)
     NS Calendar-日历
     */
     //MARK: - 时间描述-刚刚-X分钟前-X小时前-昨天
     ///  时间描述-刚刚-X分钟前-X小时前-昨天
    var descriptionDate:String{
        
        let calendar = NSCalendar.currentCalendar()
        
        // 1.判断是否是今天
        if calendar.isDateInToday(self)// @available(iOS 8.0, *)
        {
            // 1.0获取当前时间和系统时间之间的差距(秒数)
            let since = Int(NSDate().timeIntervalSinceDate(self))
            print("*since**\(since)")
            // 1.1是否是刚刚
            if since < 60
            {
                return "刚刚"
            }
            // 1.2多少分钟以前
            if since < 60 * 60
            {
                return "\(since/60)分钟前"
            }
            
            // 1.3多少小时以前
            return "\(since / (60 * 60))小时前"
        }
        
        // 2.判断是否是昨天
        var formatterStr = "HH:mm"
        if calendar.isDateInYesterday(self)
        {
            // 昨天: HH:mm
            formatterStr =  "昨天:" +  formatterStr
        }else
        {
            // 3.处理一年以内
            formatterStr = "MM-dd " + formatterStr
            
            // 4.处理更早时间
            let comps = calendar.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
            if comps.year >= 1
            {
                formatterStr = "yyyy-" + formatterStr
            }
        }
        
        // 5.按照指定的格式将时间转换为字符串
        // 5.1.创建formatter
        let formatter = NSDateFormatter()
        // 5.2.设置时间的格式
        formatter.dateFormat = formatterStr
        // 5.3设置时间的区域(真机必须设置, 否则可能不能转换成功)
        formatter.locale = NSLocale(localeIdentifier: "en")
        // 5.4格式化
        
        return formatter.stringFromDate(self)
    }
    
    

    //MARK: - 将- 时间字符串转换为-NSDate
    ///  将- 时间字符串转换为-NSDate
    class func dateWithStr(time: String) ->NSDate {
        
        // 1.1.创建formatter
        let formatter = NSDateFormatter()
        // 1.2.设置时间的格式
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
        // 1.3设置时间的区域(真机必须设置, 否则可能不能转换成功)
        formatter.locale = NSLocale(localeIdentifier: "en")
        // 1.4转换字符串, 转换好的时间是去除时区的时间
        let createdDate = formatter.dateFromString(time)!
        
        return createdDate
    }
    

}




extension NSDate{
    
    
    
    
    public func isSameDayAsDate(date: NSDate) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        let components: NSCalendarUnit = [.Month, .Day, .Year]
        
        let thisDate = calendar.components(components, fromDate: self)
        let otherDate = calendar.components(components, fromDate: date)
        
        return thisDate.month == otherDate.month &&
            thisDate.day == otherDate.day &&
            thisDate.year == otherDate.year
    }
    
    
    
    public class func dateFromString(dateString:String, format:String) -> NSDate{
        //var s = dateString.stringByReplacingOccurrencesOfString("\\", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil) as String
        //s = dateString.stringByReplacingOccurrencesOfString("T", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.dateFromString(dateString)!
    }
    
    public func toString(format:String?) -> String{
        let f = format != nil ? format : "dd/MM/yyyy HH:mm:ss"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = f
        return dateFormatter.stringFromDate(self)
    }
    
    public func toISOString() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        return dateFormatter.stringFromDate(self).stringByAppendingString("+00:00Z")
    }
    
    public class func dateFromISOString(string: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return dateFormatter.dateFromString(string)!
    }
    
    
}


//MARK: - 使用oc的框架 NSDate+Escort.m
//extension NSDate {
//    
//    class func dayNames() -> [String] {
//        
//        let dayNames = [NSLocalizedString("Sunday", comment:""),
//            NSLocalizedString("Monday", comment:""),
//            NSLocalizedString("Tuesday", comment:""),
//            NSLocalizedString("Wednesday", comment:""),
//            NSLocalizedString("Thursday", comment:""),
//            NSLocalizedString("Friday", comment:""),
//            NSLocalizedString("Saturday", comment:"")]
//        
//        if let uCalendar = self.AZ.currentCalendar() {
//            let namesBefore = Array(dayNames[0..<uCalendar.firstWeekday])
//            var names = Array(dayNames[uCalendar.firstWeekday..<dayNames.count])
//            names.extend(namesBefore)
//            
//            return names
//        }
//        
//        return dayNames
//    }
//    
//    class func shortDayNames() -> [String] {
//        
//        let dayNames = [NSLocalizedString("Su", comment:""),
//            NSLocalizedString("Mo", comment:""),
//            NSLocalizedString("Tu", comment:""),
//            NSLocalizedString("We", comment:""),
//            NSLocalizedString("Th", comment:""),
//            NSLocalizedString("Fr", comment:""),
//            NSLocalizedString("Sa", comment:"")]
//        
//        if let uCalendar = self.AZ_currentCalendar() {
//            let namesBefore = Array(dayNames[0..<uCalendar.firstWeekday])
//            var names = Array(dayNames[uCalendar.firstWeekday..<dayNames.count])
//            names.extend(namesBefore)
//            
//            return names
//        }
//        
//        return dayNames
//    }
//    
//    class func monthNames() -> [String] {
//        
//        let monthNames = [NSLocalizedString("January", comment:""),
//            NSLocalizedString("February", comment:""),
//            NSLocalizedString("March", comment:""),
//            NSLocalizedString("April", comment:""),
//            NSLocalizedString("May", comment:""),
//            NSLocalizedString("June", comment:""),
//            NSLocalizedString("July", comment:""),
//            NSLocalizedString("August", comment:""),
//            NSLocalizedString("September", comment:""),
//            NSLocalizedString("October", comment:""),
//            NSLocalizedString("November", comment:""),
//            NSLocalizedString("December", comment:"")
//        ]
//        
//        return monthNames
//    }
//    
//    
//    func relativeDateString() -> String {
//        var result: String!
//        // calculate how many days are between self and current time
//        let daysBetween = self.dateAtStartOfDay().daysAfterDate(NSDate().dateAtStartOfDay())
//        switch daysBetween {
//        case 0:
//            result = NSLocalizedString("Today", comment: "Word")
//        case 1:
//            result = NSLocalizedString("Tomorrow", comment: "Word")
//        case -1:
//            result = NSLocalizedString("Yesterday", comment: "Word")
//        case let x where x < -1:
//            result = NSLocalizedString("N_DaysAgo", comment: "Word").stringByReplacingTokensWithStrings(("NUMBER", String(abs(x))))
//        case let x where x > 1:
//            result = NSLocalizedString("In_N_Days", comment: "Word").stringByReplacingTokensWithStrings(("NUMBER", String(x)))
//        default:
//            result = "unknown"
//        }
//        
//        return result
//    }
//    
//    func dayAndMonthWithOptionalYearString() -> String {
//        var formatter: NSDateFormatter!
//        if self.year == NSDate().year {
//            formatter = NSDateFormatter.sharedDateFormatterWithFormat("d MMMM")
//        }
//        else {
//            formatter = NSDateFormatter.sharedDateFormatterWithFormat("d MMMM yyyy")
//        }
//        
//        return formatter.stringFromDate(self)
//    }
//    
//    class func dayDate(aDayNumber: Int, inMonthNumber:Int, inYearNumber: Int) -> NSDate? {
//        var date: NSDate?
//        if let uCalendar = self.AZ_currentCalendar() {
//            var components = uCalendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: self.new())
//            components.day = aDayNumber
//            components.month = inMonthNumber
//            components.year = inYearNumber
//            date = uCalendar.dateFromComponents(components)
//        }
//        return date;
//    }
//    
//    func dateOfDayFromSameMonth(aDayNumber: Int) -> NSDate? {
//        var date: NSDate?
//        if let uCalendar = NSDate.AZ_currentCalendar() {
//            var components = uCalendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitWeekday, fromDate: self)
//            components.day = aDayNumber
//            date = uCalendar.dateFromComponents(components)
//        }
//        return date;
//    }
//    
//    class func firstDayOfYear(aYearNumber: Int) -> NSDate? {
//        var date: NSDate?
//        if let uCalendar = self.AZ_currentCalendar() {
//            var components = uCalendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: self.new())
//            components.day = 1
//            components.month = 1
//            components.year = aYearNumber
//            date = uCalendar.dateFromComponents(components)
//        }
//        return date;
//    }
//    
//    class func firstDayOfMonth(aMonthNumber:Int, inYearNumber: Int) -> NSDate? {
//        var date: NSDate?
//        if let uCalendar = self.AZ_currentCalendar() {
//            var components = uCalendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: self.new())
//            components.day = 1
//            components.month = aMonthNumber
//            components.year = inYearNumber
//            date = uCalendar.dateFromComponents(components)
//        }
//        return date;
//    }
//    
//    class func firstDayOfWeek(aWeekNumber:Int, inYearNumber: Int, firstWeekday: Int) -> NSDate? {
//        var date: NSDate?
//        if let uCalendar = self.AZ_currentCalendar() {
//            var components = uCalendar.components(.CalendarUnitWeekday | .CalendarUnitWeekOfYear | .CalendarUnitYear, fromDate: self.new())
//            components.weekday = firstWeekday
//            components.weekOfYear = aWeekNumber
//            components.year = inYearNumber
//            date = uCalendar.dateFromComponents(components)
//        }
//        return date;
//    }
//    
//}
//



