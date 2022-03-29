//
//  OwnedStickerRepository.swift
//  BlankSpace
//
//  Created by Mira on 03/11/21.
//

import Foundation
import CoreData

struct OwnedStickerDataRepository {
    
    func create(record: OwnedStickerModel) {

        let cdOwnedSticker = OwnedSticker(context: PersistentStorage.shared.context)
        cdOwnedSticker.idSticker = record.idSticker
        cdOwnedSticker.buyDate = record.buyDate

        PersistentStorage.shared.saveContext()

    }

    func getAll() -> [OwnedStickerModel]? {

        let records = PersistentStorage.shared.fetchManagedObject(managedObject: OwnedSticker.self)
        guard records != nil && records?.count != 0 else {return nil}

        var results: [OwnedStickerModel] = []
        
        records!.forEach({ (cdOwnedSticker) in
            results.append(cdOwnedSticker.convertToOwnedSticker())
        })

        return results
    }

    typealias T = OwnedStickerModel
    
}

