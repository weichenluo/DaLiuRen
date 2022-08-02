//
//  calcSiZhu.swift
//  KeXueSuanMing-iOS
//
//  Created by Charlie's macmini_M1 on 2022/7/30.
//

import Foundation

struct GanZhi {
    static let tianGan = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
    static let diZhi = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
}

class SiZhu {
    var siZhu : [[Int]] = [[Int]]()
    var yueJiang = 0
    private var yuanDan = 0.0
    private var jieQi = 0.0
    private var jda : Double?
    private var dayjd = 0
    
    init(date: Date){
        //转换当日日期，string to int
        let date = date
        let calender = Calendar.current
        let components = calender.dateComponents([.year, .month, .day, .hour], from: date)
        
        guard var year = components.year,
                let month = components.month,
                let day = components.day,
                let hour = components.hour
        else{
            return
        }
        
        self.yuanDan = calcLatitude(date: "\(year)", yueJiang: false) //计算元旦用来判断是否属于前一年的年柱
        self.jieQi = calcLatitude(date: date.formatted(date: .numeric, time: .omitted), yueJiang: true) //黄道经度角度，用来判断当日属于的节气区间
        self.yueJiang = calcYueJiang(d: self.jieQi) //计算当日月将
        self.jda = convertJD(year, month, day, hour) //计算当日的儒略日
        
        // 立春前属于上一年
        if self.jieQi >= self.yuanDan && self.jieQi < 315{
            year -= 1
        }
        
        //计算四柱
        self.siZhu = [[Int]](repeating: [Int](), count: 4)
        self.siZhu[0] = calcNianZhu(year: year)
        self.siZhu[1] = calcYueZhu(month: month)
        self.siZhu[2] = calcRiZhu(day: day) ?? [0,0]
        self.siZhu[3] = calcShiZhu(hour: hour)
    }
    
    
    private func calcNianZhu(year: Int) -> [Int]{
        var nianZhu = [Int](repeating: 0, count: 2)
        nianZhu[0] = (year-4) % 10
        nianZhu[1] = (year-4) % 12
        return nianZhu
    }

    private func calcYueZhu(month: Int) -> [Int]{
        var yueZhu = [Int](repeating: 0, count: 2)
        if self.jieQi >= 345 || self.jieQi < 15 {
            yueZhu[1] = 3
        }else if self.jieQi < 45 {
            yueZhu[1] = 4
        }else if self.jieQi < 75 {
            yueZhu[1] = 5
        }else if self.jieQi < 105 {
            yueZhu[1] = 6
        }else if self.jieQi < 135 {
            yueZhu[1] = 7
        }else if self.jieQi < 165 {
            yueZhu[1] = 8
        }else if self.jieQi < 195 {
            yueZhu[1] = 9
        }else if self.jieQi < 225 {
            yueZhu[1] = 10
        }else if self.jieQi < 255 {
            yueZhu[1] = 11
        }else if self.jieQi < 285 {
            yueZhu[1] = 0
        }else if self.jieQi < 315{
            yueZhu[1] = 1
        }else{
            yueZhu[1] = 2
        }
        
        yueZhu[0] = (self.siZhu[0][0] * 2 + yueZhu[1]) % 10
        
        return yueZhu
    }

    private func calcRiZhu(day: Int) -> [Int]?{
        var riZhu = [Int](repeating: 0, count: 2)
        guard let jda = jda else {
            return nil
        }
        
        let thes = Int((jda - floor(jda)) * 86400 + 3600)
        let dayjd = Int(floor(jda)) +  thes/86400
        let dgz = ((dayjd + 49) % 60 + 60) % 60
        riZhu[0] = dgz % 10
        riZhu[1] = dgz % 12
        
        return riZhu
    }

    private func calcShiZhu(hour: Int) -> [Int]{
        var shiZhu = [Int](repeating: 0, count: 2)
        shiZhu[1] = (hour+1)/2 % 12
        let riGan = self.siZhu[2][0]
        let shiGanBegin = (riGan % 5) * 2
        shiZhu[0] = (shiGanBegin + (hour+1)/2 % 12) % 10
        return shiZhu
    }
    
    
}


