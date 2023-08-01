//
//  TaskViewEdit.swift
//  TodoApp
//
//  Created by Ecc on 01.08.23.
//

import SwiftUI

struct TaskEditView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder : DataHolder
    
    @State var selectedTaskItem : Task?
    @State var title : String
    @State var desc : String
    @State var dueDate : Date
    @State var scheduleTime : Bool
    
    init(passedTaskItem: Task?, initialDate : Date) {
        if let taskItem = passedTaskItem {
            _selectedTaskItem = State(initialValue: taskItem)
            _title = State(initialValue: taskItem.title ?? "")
            _desc = State(initialValue: taskItem.desc ?? "")
            _dueDate = State(initialValue: taskItem.dueDate ?? initialDate)
            _scheduleTime = State(initialValue: taskItem.scheduleTime)
        }else{
            _title = State(initialValue: "")
            _desc = State(initialValue: "")
            _dueDate = State(initialValue: initialDate)
            _scheduleTime = State(initialValue: false)
        }
    }
    
    var body: some View {
        Form{
            Section("Task"){
                TextField("Task Title", text: $title)
                TextField("Description", text: $desc)
            }
            Section("Due Date"){
                Toggle("Schedule Time", isOn: $scheduleTime)
                DatePicker("Due Date", selection: $dueDate,displayedComponents: scheduleTime ?  [.date,.hourAndMinute] : [.date])
            }
            if selectedTaskItem?.isCompleted() ?? false {
                Section("Completed"){
                    Text(selectedTaskItem?.completeDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
                        .foregroundColor(.green)
                }
            }
            Section{
                Button{
                    saveAction()
                }label: {
                    Text("Save")
                }
            }
        }
        
    }
    
    private func saveAction(){
        withAnimation{
            if selectedTaskItem == nil {
                selectedTaskItem = Task(context: viewContext)
            }
            selectedTaskItem?.created = Date()
            selectedTaskItem?.title = title
            selectedTaskItem?.dueDate = dueDate
            selectedTaskItem?.scheduleTime = scheduleTime
            
            dataHolder.saveContext(viewContext)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    
    func displayComps() -> DatePickerComponents {
        return scheduleTime ? [.hourAndMinute,.date] : [.date]
    }
}

struct TaskViewEdit_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(passedTaskItem: nil, initialDate: Date())
    }
}
