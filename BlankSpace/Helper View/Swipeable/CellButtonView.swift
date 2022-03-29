//
//  CellButtonView.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 09/11/21.
//

import SwiftUI

let buttonWidth: CGFloat = 80

enum CellButtons: Identifiable {
    case edit
    case delete
    case save
    case info
    
    var id: String {
        return "\(self)"
    }
}

struct CellButtonView: View {
    let data: CellButtons
    let cellHeight: CGFloat
    
    func getView(for image: String = "trash", assetImage: String = "Icon Trash", title: String, color: Color = .primary) -> some View {
        VStack {
            if assetImage.isEmpty {
                Image(systemName: image)
            }
            else {
                Image(assetImage).resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            Text(title)
                .fontWeight(.semibold)
        }.padding(5)
        .foregroundColor(color)
        .font(.body)
        .frame(width: buttonWidth, height: cellHeight)
    }
    
    var body: some View {
        switch data {
        case .edit:
            getView(for: "pencil.circle", title: "Edit")
            .background(Color.yellow)
        case .delete:
            getView(assetImage: "Icon Trash", title: "Delete", color: .red)
                .offset(x:-10,y: -10)
        case .save:
            getView(for: "square.and.arrow.down", title: "Save")
            .background(Color.blue)
        case .info:
            getView(for: "info.circle", title: "Info")
            .background(Color.green)
        }
    }
}
struct CellButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CellButtonView(data: .delete, cellHeight: 50)
    }
}
