//
//  UserPointModel.swift
//  BlankSpace
//
//  Created by Nyoman Utama Utama on 03/11/21.
//

import Foundation

class UserPointModel {
    
    let idTrans: UUID
    let amount: Int32
    let category: String
    let currentPoint: Int32
    let date: Date
    let note: String
    
    init(_idTrans: UUID, _amount: Int32, _category: String, _currentPoint: Int32, _date: Date, _note: String) {
        self.idTrans = _idTrans
        self.amount = _amount
        self.category = _category
        self.currentPoint = _currentPoint
        self.date = _date
        self.note = _note
    }
    
}
