//
//  AppData.swift
//  Project1
//
//  Created by Alexia Munoz (RIT Student) on 3/26/17.
//  Copyright © 2017 Alexia Munoz (RIT Student). All rights reserved.
//

import Foundation

class AppData{
    
    static let shared = AppData()
    
    var wordList:[String] = wordBank.share.fetchList(category: "musical")
    let dataWordList = "dataWordList"
    
    private func readDefaultsData(){
        let defaults = UserDefaults.standard
        wordList = defaults.stringArray(forKey: dataWordList) ?? [String]()
        
        if(wordList == []){
            wordList = wordBank.share.fetchList(category: "musical")
        }
    
    }
    
    private init(){
        readDefaultsData()
    }
    
    public func saveDefaultsData(){
        let defaults = UserDefaults.standard
        defaults.set(wordList,forKey: dataWordList)
        defaults.synchronize()
    }
    
    
}
