//
//  FlaotingButon.swift
//  TodoApp
//
//  Created by Ecc on 01.08.23.
//

import SwiftUI

struct FlaotingButon: View {
    @EnvironmentObject var dataHolder : DataHolder
    var body: some View {
        Spacer()
        HStack{
            NavigationLink{
                TaskEditView(passedTaskItem: nil, initialDate: Date())
                    .environmentObject(dataHolder)
            }label: {
                Text("+ New Task")
            }
            .padding(15)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(30)
            .padding(30)
            .shadow(color: .black.opacity(0.3), radius: 3,x: 3,y: 3)
        }
    }
}

struct FlaotingButon_Previews: PreviewProvider {
    static var previews: some View {
        FlaotingButon()
            .environmentObject(DataHolder(.init()))
    }
}
