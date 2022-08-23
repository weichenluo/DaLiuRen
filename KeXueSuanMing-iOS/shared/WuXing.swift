//
//  WuXing.swift
//  大六壬起盘工具
//
//  Created by Charlie's macmini_M1 on 2022/8/8.
//

import Foundation
class WuXing {
    var val : Int
    var name : String
    var XiangSheng : Int
    var XiangKe : Int
    var BeiSheng : Int
    var BeiKe : Int
    
    init(_ val : Int, _ name : String, _ xiangSheng : Int, _ xiangKe : Int, _ beiSheng : Int, _ beiKe : Int){
        self.val = val
        self.name = name
        self.XiangSheng = xiangSheng
        self.XiangKe = xiangKe
        self.BeiSheng = beiSheng
        self.BeiKe = beiKe
    }
}

// 水金木土火
// 生：水 -> 木 -> 火 -> 土 -> 金
// 克：水 -> 火 -> 金 -> 木 -> 土
func formWuXing() -> [WuXing] {
    var res = [WuXing]()
    let shui = WuXing(0, "水", 2, 4, 1, 3)
    let jin = WuXing(1, "金", 0, 2, 3, 4)
    let mu = WuXing(2, "木", 4, 3, 0, 1)
    let tu = WuXing(3, "土", 1, 0, 4, 2)
    let huo = WuXing(4, "火", 3, 1, 2, 0)
    res.append(shui)
    res.append(jin)
    res.append(mu)
    res.append(tu)
    res.append(huo)
    return res
}
