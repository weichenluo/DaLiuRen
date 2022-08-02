//
//  Pan.swift
//  盘 - 地盘、天盘、神盘
//  KeXueSuanMing-iOS
//
//  Created by Charlie's macmini_M1 on 2022/8/1.
//

import Foundation

struct GuiRen {
    static let guiRen = ["贵", "螣", "朱", "合", "勾", "青", "天", "虎", "常", "玄", "阴", "后"]
}

class Pan {
    var diPan = [Int](repeating: -1, count: 12)
    var tianPan = [Int](repeating: -1, count: 12)
    var shenPan = [Int](repeating: -1, count: 12)
    
    func paiPan(siZhu : SiZhu){
        self.createDiPan()
        self.createTianPan(siZhu)
        self.createShenPan(siZhu)
    }
    
    func createDiPan(){
        for i in 0..<12 {
            self.diPan[i] = (5+i) % 12
        }
    }
    
    func createTianPan(_ siZhu : SiZhu){
        var begin = (siZhu.siZhu[3][1] + 7) % 12
        var tmp = siZhu.yueJiang
        while self.tianPan[begin] == -1 {
            self.tianPan[begin] = tmp
            begin = (begin + 1) % 12
            tmp = (tmp + 1) % 12
        }
    }
    
    func createShenPan(_ siZhu : SiZhu){
        let isZhou = siZhu.siZhu[3][1] >= 3 && siZhu.siZhu[3][1] <= 8
        let riGan = siZhu.siZhu[2][0]
        var pos = -1
        
        if riGan == 8 || riGan == 9 {
            if isZhou {
                pos = 5
            }else{
                pos = 3
            }
        }else if riGan == 1 || riGan == 5{
            if isZhou {
                pos = 0
            }else{
                pos = 8
            }
        }else if riGan == 2 || riGan == 3{
            if isZhou {
                pos = 11
            }else{
                pos = 9
            }
        }else if riGan == 7{
            if isZhou {
                pos = 6
            }else{
                pos = 2
            }
        }else{
            if isZhou {
                pos = 1
            }else{
                pos = 7
            }
        }
        
        
        guard var tianPanP = self.tianPan.firstIndex(of: pos) else{
            print("Error in createShenPan()")
            return
        }
        
        var tmp = 0
        if self.diPan[tianPanP] >= 5 && self.diPan[tianPanP] <= 10{
            // 逆时针排盘
            while self.shenPan[tianPanP] == -1 {
                self.shenPan[tianPanP] = tmp
                tianPanP = (tianPanP + 11) % 12
                tmp += 1
            }
        }else{
            // 顺时针排盘
            while self.shenPan[tianPanP] == -1 {
                self.shenPan[tianPanP] = tmp
                tianPanP = (tianPanP + 1) % 12
                tmp += 1
            }
        }
        
    }
}
