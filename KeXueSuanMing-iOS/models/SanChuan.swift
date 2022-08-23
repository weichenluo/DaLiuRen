//
//  SanChuan.swift
//  三传
//  KeXueSuanMing-iOS
//
//  Created by Charlie's macmini_M1 on 2022/8/1.
//

import Foundation

let WXGuanXi = formWuXing()

class Chuan {
    var liuQin : String?
    var tinaGan : Int?
    var diZhi : Int?
    var shen : Int?
}

class SanChuan {
    var xiaKeShang = [[Int]]()
    var shangKeXia = [[Int]]()
    var xiaShengShang = [[Int]]()
    var shangShengXia = [[Int]]()
    var siKe : [[Int]]
    var sanChuan  = [Chuan]()
    
    init(_ siKe:SiKe){
        self.siKe = siKe.siKe
    }
    
    func findZe(){
        
    }
}
