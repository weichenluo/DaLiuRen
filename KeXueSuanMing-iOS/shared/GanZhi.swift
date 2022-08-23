//
//  GanZhi.swift
//  大六壬起盘工具
//
//  Created by Charlie's macmini_M1 on 2022/8/8.
//

import Foundation

// 阴：0 阳：1
// 水：0 金：1 木：2 土：3 火：4
class GanZhi {
    var yingYang: Int
    var wuXing: Int
    var val : Int
    var name : String
    
    init(_ yy: Int, _ wx: Int, _ val: Int, _ name: String){
        self.yingYang = yy
        self.wuXing = wx
        self.val = val
        self.name = name
    }
}

func formTianGan() -> [GanZhi]{
    var res = [GanZhi]()
    
    res.append(GanZhi(1, 2, 0, "甲"))
    res.append(GanZhi(0, 2, 1, "乙"))
    res.append(GanZhi(1, 4, 2, "丙"))
    res.append(GanZhi(0, 4, 3, "丁"))
    res.append(GanZhi(1, 3, 4, "戊"))
    res.append(GanZhi(0, 3, 5, "己"))
    res.append(GanZhi(1, 1, 6, "庚"))
    res.append(GanZhi(0, 1, 7, "辛"))
    res.append(GanZhi(1, 0, 8, "壬"))
    res.append(GanZhi(0, 0, 9, "癸"))
    
    return res
}

func formDiZhi() -> [GanZhi]{
    var res = [GanZhi]()
    
    res.append(GanZhi(1, 0, 0, "子"))
    res.append(GanZhi(0, 3, 1, "丑"))
    res.append(GanZhi(1, 2, 2, "寅"))
    res.append(GanZhi(0, 2, 3, "卯"))
    res.append(GanZhi(1, 3, 4, "辰"))
    res.append(GanZhi(0, 4, 5, "巳"))
    res.append(GanZhi(1, 4, 6, "午"))
    res.append(GanZhi(0, 3, 7, "未"))
    res.append(GanZhi(1, 1, 8, "申"))
    res.append(GanZhi(0, 1, 9, "酉"))
    res.append(GanZhi(1, 3, 10, "戌"))
    res.append(GanZhi(0, 0, 11, "亥"))
    
    return res
}

