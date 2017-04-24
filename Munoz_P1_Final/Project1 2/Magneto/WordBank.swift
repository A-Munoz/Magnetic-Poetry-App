//
//  WordBank.swift
//  Project1
//
//  Created by Alexia Munoz (RIT Student) on 3/25/17.
//  Copyright © 2017 Alexia Munoz (RIT Student). All rights reserved.
//

import Foundation

//Holds all word lists 
class wordBank{
    
    static let share = wordBank()
    
    //Array of Word Lists
    let comedy = ["When","I","Think","I","Must","Speak","I","Wish","My","Horse","had","the","speed","of","your","tongue","Wow","sarcasm","That's","original","nemesis","I","love","the","air","what","?", "the", "clock","time","wait","sleep","was","is","when","hopeless","late"]
    let tragedy = ["Sorrow","Tis","Shadow", "a", "love", "the", "poison", "heart's", "breaking", "fortune","false","heard","no","more","Hamlet","Macbeth","death","arrow","enemy","vengence","lost","loss", "rest", "grave","ghost","was","is","a","this", "quiet", "scream", "fate","doom","dawnfall", "trapped", "hollow", "candlestick", "red", "wine"]
    let drama = ["Lightning","Shew","cold","the","end","disastrous","Love","looks","not","with","eyes","but","with","the","mind","fools","these","mortals","reason","yet","truth","together","apprehend","night's","slumber","Late","!","hate","murder","Butler", "money", "stolen", "caught", "caller","curtian","closed","fire","escape"]
    let musical = ["Sing","Rain","Eleven","Burn","Leo","good!","My","Eyes","Everything","You","Ever","Slipping","Comedy","Tonight","A","Star","the","is","was","Theodosia","Helpless","Wait","For","It","Opera","Inutil","Sunrise","It","Won't","Be","Long","Now","Godspell", "Producer", "City", "El Dorado", "Story", "Told", "Melody" ]
    
//Gets List of Words
    func fetchList(category:String)->[String]{
        
     /* switch category {
        case "comedy":
            return comedy
        case "tragedy":
            return tragedy
        case "drama":
            return drama
        case "musical":
            return musical
        default:
            return comedy
        }*/
        
   ///TESTING////
        //Getting random words from list
        var List:[String] = []
         var Type:[String] = []
        
        if(category == "comedy"){
            Type = comedy
        } else if(category == "tragedy"){
            Type = tragedy
        }else if(category == "drama"){
            Type = drama
        }else{
            Type = musical
        }
        
       // var index:[Int] = []
        var i = 0;
        while i <= 10 {
            
            let random:Int = Int(arc4random_uniform(36))
            let word:String = Type[random]
            List.append(word)
            i = i + 1;
        }
        
        return List

    }
}
