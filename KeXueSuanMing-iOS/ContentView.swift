//
//  ContentView.swift
//  KeXueSuanMing-iOS
//
//  Created by Charlie's macmini_M1 on 2022/7/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var siZhu : SiZhu?
    @State var date = Date()
    @State var pan = Pan()
    let wuXing = ["水", "金", "木", "土", "火"]
    
    
    var body: some View {
        
        if let siZhu = siZhu {
            Text("四柱：\(tianGan[siZhu.siZhu[0][0]].name)\(diZhi[siZhu.siZhu[0][1]].name)年 \(tianGan[siZhu.siZhu[1][0]].name)\(diZhi[siZhu.siZhu[1][1]].name)月 \(tianGan[siZhu.siZhu[2][0]].name)\(diZhi[siZhu.siZhu[2][1]].name)日 \(tianGan[siZhu.siZhu[3][0]].name)\(diZhi[siZhu.siZhu[3][1]].name)时")
            Text("月将：\(diZhi[siZhu.yueJiang].name)")
            Button {
                self.siZhu = nil
                self.pan = Pan()
            } label: {
                Text("reset")
            }

        }else{
            DatePicker(
                "选择日期：",
                selection: $date,
                displayedComponents: [.date, .hourAndMinute]
            ).datePickerStyle(.compact).frame(width: UIScreen.main.bounds.width * 0.8)
            
            Text("please calc first")
            
            Button {
                self.siZhu = SiZhu(date: date)
                self.pan.paiPan(siZhu: self.siZhu!)
                let siKe = SiKe(pan: self.pan, siZhu: self.siZhu!)
                
                print("排盘")
                print(self.pan.diPan.map{diZhi[$0].name})
                print(self.pan.tianPan.map{diZhi[$0].name})
                print(self.pan.shenPan.map{GuiRen.guiRen[$0]})
                
                
                for i in 0..<4 {
                    if i == 0 {
                        print("第\(i+1)课: \(tianGan[self.siZhu!.siZhu[2][0]].name)\(diZhi[siKe.siKe[i][1]].name)\(GuiRen.guiRen[siKe.siKe[i][2]])")
                    }else{
                        print("第\(i+1)课: \(diZhi[siKe.siKe[i][0]].name)\(diZhi[siKe.siKe[i][1]].name)\(GuiRen.guiRen[siKe.siKe[i][2]])")
                    }
                }
                
                let sanChuan = SanChuan(siKe, self.siZhu!)
                sanChuan.zeiKe()
            } label: {
                Text("计算四柱及月将")
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
