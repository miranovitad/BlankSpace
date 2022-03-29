//
//  FilterModalView.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 19/10/21.
//

import SwiftUI

enum FilterType {
    case mood, category, all
}

struct FilterModalView: View {
    
    @ObservedObject var viewModel: FilterModalViewModel
    var filterType: FilterType = .all
    
    var body : some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    viewModel.resetFilter()
                }, label: {
                    Text("Reset")
                        .foregroundColor(.appColorDarkGrey)
                        .fontWeight(.semibold)
                })
                Spacer()
                Button(action: {
                    viewModel.applyFilter()
                }, label: {
                    Text("Apply")
                        .foregroundColor(.appColorPrimary)
                        .fontWeight(.semibold)
                })
            }.padding(.bottom, 20)
            Spacer()
            TagCloudContainer(type: filterType, moodString: viewModel.moodString, categoryString: viewModel.categoryString, moodIndex: $viewModel.viewModelToRefresh.filter.moodIndex, categoryIndex: $viewModel.viewModelToRefresh.filter.categoryIndex)
        }
        .padding()
    }
}


struct FilterModalView_Previews: PreviewProvider {
    static var previews: some View {
        FilterModalView(viewModel: FilterModalViewModel(parentViewModel: JournalListViewModel()))
    }
}
