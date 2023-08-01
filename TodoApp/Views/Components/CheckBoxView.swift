//
//  CheckBoxView.swift
//  TodoApp
//
//  Created by Ecc on 01.08.23.
//

import SwiftUI

struct CheckBoxView: View {
    @EnvironmentObject var dataHolder : DataHolder
    @ObservedObject var passedTaskItem : Task
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        Image(systemName: passedTaskItem.isCompleted() ? "checkmark.circle.fill" : "circle")
            .foregroundColor(passedTaskItem.isCompleted() ? .green : .secondary)
            .onTapGesture {
                if !passedTaskItem.isCompleted(){
                    passedTaskItem.completeDate = Date()
                    dataHolder.saveContext(viewContext)
                }
            }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(passedTaskItem: .init(context: PersistenceController.shared.container.viewContext))
    }
}
