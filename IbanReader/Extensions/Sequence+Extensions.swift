//
//  Sequence+Extensions.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
