//
//  Realm.swift
//  WaveEnterprise (iOS)
//
//  Created by Vince Santos on 1/26/22.
//
import RealmSwift
import Foundation

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
