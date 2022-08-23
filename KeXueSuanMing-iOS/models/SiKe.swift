//
//  SiKe.swift
//  四课
//  KeXueSuanMing-iOS
//
//  Created by Charlie's macmini_M1 on 2022/8/1.
//

import Foundation



class SiKe {
    var siKe = [[Int]](repeating: [Int](repeating: -1, count: 3), count: 4)
    
    private let jiGongs : [Int:Int] = [0:2, 1:4, 2:5, 3:7, 4:5, 5:7, 6:8, 7:10, 8:11, 9:1]
    
    init(pan : Pan, siZhu: SiZhu){
        self.paiYiKe(pan, siZhu)
        self.paiErKe(pan)
        self.paiSanKe(pan, siZhu)
        self.paiSiKe(pan)
    }
    
    private func paiYiKe(_ pan : Pan,  _ siZhu : SiZhu){
        let jiGong = jiGongs[siZhu.siZhu[2][0]]!
        let loc = (jiGong + 7) % 12
        self.siKe[0][0] = pan.diPan[loc]
        self.siKe[0][1] = pan.tianPan[loc]
        self.siKe[0][2] = pan.shenPan[loc]
        self.siKe[1][0] = self.siKe[0][1]
    }
    
    private func paiErKe(_ pan : Pan){
        let loc = (self.siKe[1][0] + 7) % 12
        self.siKe[1][1] = pan.tianPan[loc]
        self.siKe[1][2] = pan.shenPan[loc]
    }
    
    private func paiSanKe(_ pan : Pan, _ siZhu : SiZhu){
        let loc = (siZhu.siZhu[2][1] + 7) % 12
        self.siKe[2][0] = pan.diPan[loc]
        self.siKe[2][1] = pan.tianPan[loc]
        self.siKe[2][2] = pan.shenPan[loc]
        self.siKe[3][0] = self.siKe[2][1]
    }
    
    private func paiSiKe(_ pan : Pan){
        let loc = (self.siKe[3][0] + 7) % 12
        self.siKe[3][1] = pan.tianPan[loc]
        self.siKe[3][2] = pan.shenPan[loc]
    }
}
