//
//  UserPointRepository.swift
//  BlankSpace
//
//  Created by Mira on 03/11/21.
//

import Foundation
import CoreData

struct UserPointDataRepository {

    func create(record: UserPointModel) {

        let cdUserPoint = UserPoint(context: PersistentStorage.shared.context)
        cdUserPoint.idTrans = record.idTrans
        cdUserPoint.amount = record.amount
        cdUserPoint.category = record.category
        cdUserPoint.currentPoint = record.currentPoint
        cdUserPoint.date = record.date
        cdUserPoint.note = record.note

        PersistentStorage.shared.saveContext()

    }

    func getAll() -> [UserPointModel]? {

        let records = PersistentStorage.shared.fetchManagedObject(managedObject: UserPoint.self)
        guard records != nil && records?.count != 0 else {return nil}

        var results: [UserPointModel] = []
        
        records!.forEach({ (cdUserPoint) in
            results.append(cdUserPoint.convertToUserPoint())
        })

        return results
    }

    typealias T = UserPointModel
}

