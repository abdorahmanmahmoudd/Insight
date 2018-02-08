//
//  Enumerations.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/1/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import Foundation

enum Categories : Int{
    
    case units = 1
    case story = 2
    case skills = 5
    case guide = 6
    case revision = 4
    case exams = 3
    
    var desc: String {
        get {
            switch self {
                
            case .units:
                return "Units"
            case .story:
                return "Story"
            case .skills:
                return "Skills"
            case .guide:
                return "Studen Evaluation Guide"
            case .revision:
                return "Final Revision"
            case .exams:
                return "Exams"

            }
        }
    }
}

enum QuestionTypes : String {
    
    case Antonym = "Antonym"
    case Complete = "Complete"
    case Dictation = "Dictation"
    case Listening = "Listening"
    case Match = "Match"
    case MCQ = "MCQ"
    case MiniDialog = "MiniDialogues"
    case Mistakes = "Mistakes"
    case Rewrite = "Rewrite"
    case Situations = "Situations"
    case Translation = "Translation"
    case Writing = "Writing"
    case Prereading = "Prereading"
    case Quotations = "Quotations"
    case TrueFalse = "TrueFalse"
}
