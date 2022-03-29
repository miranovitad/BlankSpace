//
//  TagCloudContainer.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 25/10/21.
//

import SwiftUI

struct TagCloudContainer: View {
    let type: FilterType
    let moodString: [String]
    let categoryString: [String]
    
    @Binding var moodIndex: Set<Int>
    @Binding var categoryIndex: Set<Int>
    
    var body: some View {
        if type == .mood || type == .all {
            Text("Mood").font(.headline)
            TagCloudView(tags: moodString, activeTag: $moodIndex)
                .changeLayoutType(.vstack)
                .defaultColor(foreground: .black, background: .appColorGrey)
                .activeColor(foreground: .white, background: .appColorPrimary)
                .changePadding(spacing: 8, vPadding: 10, hPadding: 15)
        }
        if type == .category || type == .all {
            Text("Category").font(.headline)
            TagCloudView(tags: categoryString, activeTag: $categoryIndex)
                .changeLayoutType(.vstack)
                .defaultColor(foreground: .black, background: .appColorGrey)
                .activeColor(foreground: .white, background: .appColorPrimary)
                .changePadding(spacing: 8, vPadding: 10, hPadding: 15)
        }
    }
}

struct TagCloudContainer_Previews: PreviewProvider {
    static var previews: some View {
        TagCloudContainer(type: .all, moodString: ["Nangis", "Bahagia"], categoryString: ["Family", "School"], moodIndex: .constant([1,2]), categoryIndex: .constant([0]))
    }
}
