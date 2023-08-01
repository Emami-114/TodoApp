//
//  TaskCell.swift
//  TodoApp
//
//  Created by Ecc on 01.08.23.
//

import SwiftUI

struct TaskCell: View {
    @EnvironmentObject var dataHolder : DataHolder
    @ObservedObject var passedTaskItem : Task
    var body: some View {
        CheckBoxView(passedTaskItem: passedTaskItem)
            .environmentObject(dataHolder)
        Text(passedTaskItem.title ?? "")
            .padding(.horizontal)
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(passedTaskItem: Task(context: PersistenceController.shared.container.viewContext))
    }
}
