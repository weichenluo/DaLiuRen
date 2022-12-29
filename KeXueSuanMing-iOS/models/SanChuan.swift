//
//  SanChuan.swift
//  三传
//  KeXueSuanMing-iOS
//
//  Created by Charlie's macmini_M1 on 2022/8/1.
//

import Foundation

let Xun = [
    [0,1,2,3,4,5,6,7,8,9],
    [10,11,0,1,2,3,4,5,6,7],
    [8,9,10,11,0,1,2,3,4,5],
    [6,7,8,9,10,11,0,1,2,3],
    [4,5,6,7,8,9,10,11,0,1],
    [2,3,4,5,6,7,8,9,10,11],
]

struct Chuan {
    var liuQin : Int?
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
    var siZhu: [[Int]]
    var sanChuan  = [Chuan](repeating: Chuan(), count: 3)
    var pan : Pan
    
    init(_ siKe:SiKe, _ siZhu:SiZhu, _ pan:Pan){
        self.siKe = siKe.siKe
        self.siZhu = siZhu.siZhu
        self.pan = pan
        select()
    }
    
    func findZeiKe()->([Int], [Int]){
        var theft = [Int](), restrain = [Int]()
        for idx in 0..<4{
            let ke = self.siKe[idx]
            
            let di = idx == 0 ? TianGan[self.siZhu[2][0]] : DiZhi[ke[0]]
            
            let tian = DiZhi[ke[1]]
            
            if WXGuanXi[di.wuXing].XiangKe == tian.wuXing{
                theft.append(idx)
            }
            if WXGuanXi[di.wuXing].BeiKe == tian.wuXing{
                restrain.append(idx)
            }
        }
        return (theft, restrain)
    }
    
    func select(){
        let zk = findZeiKe()
        let theft = zk.0
        let restrain = zk.1
        
        print("贼\(theft)")
        print("克\(restrain)")
        
        if theft.count == 1 {
            print("贼克法：一贼")
            zeiKe(loc: theft)
            return
        }else if theft.count > 1 {
            var count = [[Int]](repeating: [Int](), count: 2)
            for i in theft{
                count[DiZhi[self.siKe[i][1]].yingYang].append(i)
            }
            if count[TianGan[self.siKe[2][0]].yingYang].count == 1 {
                print("比用法：多贼")
                biYong(ke: theft)
                return
            }else{
                print("涉害法: 多贼")
                return
            }
        }
        
        if restrain.count == 1{
            print("贼克法：一克")
            zeiKe(loc: restrain)
            return
        }else if restrain.count > 1 {
            var count = [Int](repeating: 0, count: 2)
            for i in restrain{
                count[DiZhi[self.siKe[i][1]].yingYang] += 1
            }
            if count[TianGan[self.siKe[2][0]].yingYang] == 1 {
                print("比用法：多克")
                return
            }else{
                print("涉害法: 多克")
                return
            }
        }
        
        
        print("无贼克")
        return
    }
    
    private func findXun(_ zhi:Int) -> Int?{
        let riGan = self.siZhu[2][0], riZhi = self.siZhu[2][1]
        var r = -1, c = -1
        for i in 0..<6 {
            for j in 0..<10 {
                if j == riGan && riZhi == Xun[i][j] {
                    r = i
                }
            }
        }
        if r == -1 {
            return nil
        }
        for k in 0..<10 {
            if zhi == Xun[r][k] {
                c = k
            }
        }
        
        return (c != -1) ? c : nil
    }
    
    private func findLiuQin(_ wo:GanZhi, _ zhi:GanZhi) -> Int{
        let woWX = WXGuanXi[wo.wuXing]
        let zhiWX = WXGuanXi[zhi.wuXing]
        if woWX.val == zhiWX.val {
            return 0
        }else if woWX.BeiKe == zhiWX.val{
            return 1
        }else if woWX.XiangKe == zhiWX.val{
            return 2
        }else if woWX.XiangSheng == zhiWX.val{
            return 3
        }else{
            return 4
        }
        
    }
    
    func zeiKe(loc: [Int]){
        
        let wo = self.siZhu[2][0]
        
        var dizhi = siKe[loc[0]][1]
        var xun = findXun(dizhi)
        var index = -1
        
        for i in 0..<12 {
            if pan.tianPan[i]==dizhi{
                index = i
            }
        }
        
        sanChuan[0].diZhi = dizhi
        sanChuan[0].tinaGan = xun
        sanChuan[0].shen = pan.shenPan[index]
        sanChuan[0].liuQin = findLiuQin(TianGan[wo], DiZhi[dizhi])
        
        
        for i in 0..<12 {
            if pan.diPan[i]==dizhi{
                index = i
            }
        }
        
        dizhi = pan.tianPan[index]
        xun = findXun(dizhi)
        
        sanChuan[1].diZhi = dizhi
        sanChuan[1].tinaGan = xun
        sanChuan[1].shen = pan.shenPan[index]
        sanChuan[1].liuQin = findLiuQin(TianGan[wo], DiZhi[dizhi])
        
        for i in 0..<12 {
            if pan.diPan[i]==dizhi{
                index = i
            }
        }
        
        dizhi = pan.tianPan[index]
        xun = findXun(dizhi)
        
        sanChuan[2].diZhi = dizhi
        sanChuan[2].tinaGan = xun
        sanChuan[2].shen = pan.shenPan[index]
        sanChuan[2].liuQin = findLiuQin(TianGan[wo], DiZhi[dizhi])

        
        let array = ["初", "中", "末"]
        for i in 0..<3{
            let a = LiuQin[sanChuan[i].liuQin!]
            let b = sanChuan[i].tinaGan != nil ? TianGan[sanChuan[i].tinaGan!].name : "空"
            let c = DiZhi[sanChuan[i].diZhi!].name
            let d = GuiRen.guiRen[sanChuan[i].shen!]
            
            print("\(array[i]): \(a) \(b) \(c) \(d)")
        }
        
        
    }
    
    func biYong(ke : [Int]){
        var index = -1
        for i in 0..<ke.count {
            let loc = ke[i]
            if DiZhi[siKe[loc][1]].yingYang == DiZhi[siZhu[2][1]].yingYang{
                index = loc
            }
        }
        
        zeiKe(loc: [index])
    }
    
    func sheHai(){}
}
