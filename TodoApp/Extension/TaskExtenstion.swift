//
//  TaskExtenstion.swift
//  TodoApp
//
//  Created by Ecc on 01.08.23.
//

import SwiftUI
extension Task {
    func isCompleted() -> Bool {
        return completeDate != nil
    }
}
