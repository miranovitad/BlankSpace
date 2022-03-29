//
//  UserPointExtensions.swift
//  BlankSpace
//
//  Created by Mira on 03/11/21.
//

import Foundation

extension UserPoint
{
    func convertToUserPoint() -> UserPointModel
    {
        return UserPointModel(_idTrans: self.idTrans!, _amount: self.amount, _category: self.category!, _currentPoint: self.currentPoint, _date: self.date!, _note: self.note!)
    }
}
