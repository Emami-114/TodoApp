//
//  TaskListView.swift
//  TodoApp
//
//  Created by Ecc on 01.08.23.
//

import SwiftUI
import CoreData
struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder : DataHolder
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.dueDate, ascending: true)],animation: .default)
    
    private var items : FetchedResults<Task>
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    List{
                        ForEach(items){item in
                            NavigationLink {
                                TaskEditView(passedTaskItem: item, initialDate: Date())
                                    .environmentObject(dataHolder)
                            } label: {
                                TaskCell(passedTaskItem: item)
                                    .environmentObject(dataHolder)
                            }

                        }
                        .onDelete(perform: deleteItem)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing){
                            EditButton()
                           
                        }
                    }
                    FlaotingButon()
                        .environmentObject(dataHolder)
                }
            }
            .navigationTitle("Todo App")
        }
        
    }
    
    private func deleteItem(offsets:IndexSet){
        withAnimation {
            offsets.map{ items[$0]}.forEach(viewContext.delete(_:))
            dataHolder.saveContext(viewContext)
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
