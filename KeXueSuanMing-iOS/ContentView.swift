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
    
    
    var body: some View {
        
        DatePicker(
            "选择日期：",
            selection: $date,
            displayedComponents: [.date, .hourAndMinute]
        ).datePickerStyle(.compact).frame(width: UIScreen.main.bounds.width * 0.8)
        
        
        
        if let siZhu = siZhu {
            Text("四柱：\(GanZhi.tianGan[siZhu.siZhu[0][0]])\(GanZhi.diZhi[siZhu.siZhu[0][1]])年 \(GanZhi.tianGan[siZhu.siZhu[1][0]])\(GanZhi.diZhi[siZhu.siZhu[1][1]])月 \(GanZhi.tianGan[siZhu.siZhu[2][0]])\(GanZhi.diZhi[siZhu.siZhu[2][1]])日 \(GanZhi.tianGan[siZhu.siZhu[3][0]])\(GanZhi.diZhi[siZhu.siZhu[3][1]])时")
            Text("月将：\(GanZhi.diZhi[siZhu.yueJiang])")
            Button {
                self.siZhu = nil
                self.pan = Pan()
            } label: {
                Text("reset")
            }

        }else{
            Text("please calc first")
            Button {
                self.siZhu = SiZhu(date: date)
                self.pan.paiPan(siZhu: self.siZhu!)
                print("排盘")
                print(self.pan.diPan.map{GanZhi.diZhi[$0]})
                print(self.pan.tianPan.map{GanZhi.diZhi[$0]})
                print(self.pan.shenPan.map{GuiRen.guiRen[$0]})
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
