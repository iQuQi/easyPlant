//
//  userPlant.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import Foundation

struct userPlant{
    var name: String
    var location: String
    let registedDate : String
    var waterPeriod : Int
    var wateringDay : String
    let plantSpecies : String
    var sunLight : Int
    var temperature : Double
    var diarylist : [Diary]
    var color : (Int,Int,Int)
    var happeniess : Double
    var alarmTime : Double
    var plantImage : String

}


var userPlants : [userPlant] = [userPlant(name: "초록콩", location: "책상 위", registedDate: "2010-10-30",        waterPeriod: 28, wateringDay: "2020.4.30", plantSpecies: "스투키", sunLight: 20, temperature: 22.3, diarylist: diarys, color: (0,255,0), happeniess: 85.5, alarmTime: 10.0,plantImage: "plant1"),
                                userPlant(name: "초록콩1", location: "책상 위", registedDate: "2010-10-30", waterPeriod: 28, wateringDay: "2020.4.30", plantSpecies: "스투키", sunLight: 20, temperature: 22.3, diarylist: diarys, color: (0,255,0), happeniess: 85.5, alarmTime: 10.0,plantImage: "plant1"),
                                userPlant(name: "초록콩2", location: "책상 위", registedDate: "2010-10-30", waterPeriod: 28, wateringDay: "2020.4.30", plantSpecies: "스투키", sunLight: 20, temperature: 22.3, diarylist: diarys, color: (0,255,0), happeniess: 85.5, alarmTime: 10.0,plantImage: "plant1")]
