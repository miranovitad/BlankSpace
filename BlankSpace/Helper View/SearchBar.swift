//
//  SearchBarr.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 22/10/21.
//

import SwiftUI

struct SearchBar: View{
    @Binding var searchText: String
    @Binding var textFieldId: String
    @State private var isEditing = false
    let names = ["Holly", "Josh", "Rhonda", "Ted"]
    
    var body: some View{
        TextField("Search", text: $searchText)
            .id(textFieldId)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    
                    if isEditing {
                        Button(action: {
                            self.searchText = ""
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .onTapGesture {
                self.isEditing = true
            }
    }
    
    var searchResult: [String]{
        if searchText.isEmpty{
            return names
        } else {
            return names.filter{
                $0.contains(searchText)
            }
        }
    }
}
//    struct SearchBar_Previews: PreviewProvider {
//        static var previews: some View {
//            SearchBar()
//        }
//    }
