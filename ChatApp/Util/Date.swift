//
//  Date.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 29/07/24.
//

import Foundation
extension Date{
    private var dayFormatter : DateFormatter{
        let formatte  = DateFormatter()
        formatte.timeStyle = .medium
        formatte.dateFormat = "dd/MM/yy"
        return formatte
    }
    func chatTimetampString() -> String{
        if Calendar.current.isDateInToday(self){
            return "Hoje"
        }else if Calendar.current.isDateInYesterday(self){
            return "Ontem"
        }else {
            return dayFormatter.string(from: self)
        }
    }
}
