//
//  calcJD.swift
//  KeXueSuanMing-iOS
//
//  Created by Charlie's macmini_M1 on 2022/7/26.
//

import Foundation

func convertJDDate(date:Date) -> Double{
//    let formatter = DateFormatter()
//    let dateFormatter = "yyyy/MM/dd HH:mm:ss"
    let JD_JAN_1_1970_0000GMT = 2440587.5
//    formatter.dateFormat = dateFormatter
//    let date = formatter.date(from: "\(date) 11:59:59")!
    return JD_JAN_1_1970_0000GMT + date.timeIntervalSince1970 / 86400.0
}

func convertJDString(date:String) -> Double{
    let formatter = DateFormatter()
    let dateFormatter = "yyyy/MM/dd HH:mm:ss"
    let JD_JAN_1_1970_0000GMT = 2440587.5
    formatter.dateFormat = dateFormatter
    let date = formatter.date(from: "\(date)/1/1 00:00:00")!
    return JD_JAN_1_1970_0000GMT + date.timeIntervalSince1970 / 86400.0
}

func convertJD(_ y:Int, _ m:Int, _ d:Int, _ h:Int) -> Double?{
    let y = Double(y)
    let m = Double(m)
    let d = Double(d)
    let h = Double(h)
    
    let yp = y + floor((m-3)/10)
    var jdy = 0.0
    var initJD = 0.0
    if y > 1582 || (y == 1582 && m > 10) || (y == 1582 && m == 10 && d>=15) {
        initJD = 1721119.5
        jdy = floor(yp * 365.25) - floor(yp/100) + floor(yp/400)
    }else{
        if y < 1582 || y == 1582 && m < 10 || y == 1582 && m == 10 && d < 15 {
            initJD = 1721117.5
            jdy = floor(yp * 365.25);
        }else{
            return nil
        }
    }
    let mp = Int(floor(m + 9)) % 12
    let jdm = mp * 30 + Int((mp+1) * 34 / 57)
    let jdd = d - 1
    let jdh = h/24
    return jdy + Double(jdm) + jdd + jdh + initJD + 0.5
}

func calcLatitude(date: Date) -> Double{
    let deg2rad = Double.pi / 180.000
    
    // calc today's Julian Date
    let JD = convertJDDate(date: date)
    // calc date base on 2000-1-1
    let n:Double = JD - 2451545.0000
    
    // starting with the mean longitude of the sun in degrees, corrected for aberation
    var meanlong_degrees = 280.460 + (0.9856474 * n)
//    meanlong_degrees = meanlong_degrees.truncatingRemainder(dividingBy: 360.0)
    if meanlong_degrees > 0 {
        while meanlong_degrees > 360 {
            meanlong_degrees -= 360
        }
    }else{
        while meanlong_degrees < 0 {
            meanlong_degrees += 360
        }
    }
    
    // and the mean anomaly in degrees
    var meananomaly_degrees = 357.528 + (0.9856003 * n)
    meananomaly_degrees = meananomaly_degrees.truncatingRemainder(dividingBy: 360.0)
    
    
    let meananomaly_radians = meananomaly_degrees * deg2rad
    
    var elipticlong_degrees = meanlong_degrees + (1.915 * sin(meananomaly_radians)) + (0.020 * sin(2 * meananomaly_radians))
    elipticlong_degrees = elipticlong_degrees.truncatingRemainder(dividingBy: 360.0)
    
    return elipticlong_degrees
}

func calcLatitude(date: String) -> Double{
    let deg2rad = Double.pi / 180.000
    
    // calc today's Julian Date
    let JD = convertJDString(date: date)
    // calc date base on 2000-1-1
    let n:Double = JD - 2451545.0000
    
    // starting with the mean longitude of the sun in degrees, corrected for aberation
    var meanlong_degrees = 280.460 + (0.9856474 * n)
//    meanlong_degrees = meanlong_degrees.truncatingRemainder(dividingBy: 360.0)
    if meanlong_degrees > 0 {
        while meanlong_degrees > 360 {
            meanlong_degrees -= 360
        }
    }else{
        while meanlong_degrees < 0 {
            meanlong_degrees += 360
        }
    }
    
    // and the mean anomaly in degrees
    var meananomaly_degrees = 357.528 + (0.9856003 * n)
    meananomaly_degrees = meananomaly_degrees.truncatingRemainder(dividingBy: 360.0)
    
    
    let meananomaly_radians = meananomaly_degrees * deg2rad
    
    var elipticlong_degrees = meanlong_degrees + (1.915 * sin(meananomaly_radians)) + (0.020 * sin(2 * meananomaly_radians))
    elipticlong_degrees = elipticlong_degrees.truncatingRemainder(dividingBy: 360.0)
    
    return elipticlong_degrees
}

func calcYueJiang(d: Double) -> Int {
    if d < 30 {
        return 10
    }else if d < 60 {
        return 9
    }else if d < 90 {
        return 8
    }else if d < 120 {
        return 7
    }else if d < 150 {
        return 6
    }else if d < 180 {
        return 5
    }else if d < 210 {
        return 4
    }else if d < 240 {
        return 3
    }else if d < 270 {
        return 2
    }else if d < 300 {
        return 1
    }else if d < 330 {
        return 0
    }else {
        return 11
    }
}
