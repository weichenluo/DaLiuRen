//
//  SanChuan.swift
//  三传
//  KeXueSuanMing-iOS
//
//  Created by Charlie's macmini_M1 on 2022/8/1.
//

import Foundation


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
    var siZhu: [[Int]]
    var sanChuan  = [Chuan]()
    
    init(_ siKe:SiKe, _ siZhu:SiZhu){
        self.siKe = siKe.siKe
        self.siZhu = siZhu.siZhu
        select()
    }
    
    func findZeiKe()->([Int], [Int]){
        var theft = [Int](), restrain = [Int]()
        for idx in 0..<4{
            let ke = self.siKe[idx]
            
            let di = idx == 0 ? tianGan[self.siZhu[2][0]] : diZhi[ke[0]]
            
            let tian = diZhi[ke[1]]
            
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
            return
        }else if theft.count > 1 {
            var count = [Int](repeating: 0, count: 2)
            for i in theft{
                count[diZhi[self.siKe[i][1]].yingYang] += 1
            }
            if count[tianGan[self.siKe[2][0]].yingYang] == 1 {
                print("比用法：多贼")
                return
            }else{
                print("涉害法: 多贼")
                return
            }
        }
        
        if restrain.count == 1{
            print("贼克法：一克")
            return
        }else if restrain.count > 1 {
            var count = [Int](repeating: 0, count: 2)
            for i in restrain{
                count[diZhi[self.siKe[i][1]].yingYang] += 1
            }
            if count[tianGan[self.siKe[2][0]].yingYang] == 1 {
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
    
    func zeiKe(){}
    
    func biYong(){}
    
    func sheHai(){}
}
