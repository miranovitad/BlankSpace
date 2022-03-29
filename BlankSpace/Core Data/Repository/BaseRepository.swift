//
//  BaseRepository.swift
//  BlankSpace
//
//  Created by Mira Novita Dewi Ni Putu on 23/10/21.
//

import Foundation

protocol BaseRepository {

    associatedtype T

    func create(record: T)
    func getAll() -> [T]?
    func get(byIdentifier id: UUID) -> T?
    func update(record: T) -> Bool
    func delete(byIdentifier id: UUID) -> Bool
}

protocol BaseRepositoryIdString {

    associatedtype T

    func create(record: T)
    func getAll() -> [T]?
    func get(byIdentifier id: String) -> T?
    func update(record: T) -> Bool
    func delete(byIdentifier id: String) -> Bool
}
