//
//  TagCloudView.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 18/10/21.
//

import SwiftUI

enum TagLayout {
    case scrollView, vstack
}

struct TagCloudView: View {
    var tags: [String]
    
    var foregroundColor: Color = .white
    var backgroundColor: Color = .gray
    var activeForegroundColor: Color = .white
    var activeBackgroundColor: Color = .blue
    var layoutType = TagLayout.vstack
    
    
    var spacing: CGFloat = 8
    var hPadding: CGFloat = 10
    var vPadding: CGFloat = 5
    
    @State private var totalHeight
        = CGFloat.infinity   // << variant for VStack
    
    @Binding var activeTag: Set<Int>
    
    var body: some View {
        
        if layoutType == .scrollView {
            VStack {
                GeometryReader { geometry in
                    self.generateContent(in: geometry)
                }
            }
            .frame(height: totalHeight)// << variant for ScrollView/List
        }
        else if layoutType == .vstack {
            VStack {
                GeometryReader { geometry in
                    self.generateContent(in: geometry)
                }
            }
            .frame(maxHeight: totalHeight) // << variant for VStack
        }
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.tags.indices, id: \.self) { index in
                self.item(for: tags[index], idx: index)
                    .padding([.horizontal, .bottom], spacing)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tags[index] == self.tags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tags[index] == self.tags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
                
            }
        }.background(viewHeightReader($totalHeight))
        .padding(.horizontal, -spacing)
    }
    
    private func item(for text: String, idx: Int) -> some View {
        
        Button(action: {
            selectedTag(tag: idx)
        }, label: {
            if activeTag.contains(idx) {
                Text(text)
                    .padding(.horizontal, hPadding)
                    .padding(.vertical, vPadding)
                    .font(.body)
                    .background(activeBackgroundColor)
                    .foregroundColor(activeForegroundColor)
                    .cornerRadius(5)
            }
            else {
                Text(text)
                    .padding(.horizontal, hPadding)
                    .padding(.vertical, vPadding)
                    .font(.body)
                    .background(backgroundColor)
                    .foregroundColor(foregroundColor)
                    .cornerRadius(5)
            }
        })
    }
    
    private func selectedTag(tag: Int) {
        if activeTag.contains(tag) {
            activeTag.remove(tag)
        }
        else {
            activeTag.insert(tag)
        }
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
    
    /// Change layout regarding parent view type
    public func changeLayoutType(_ type: TagLayout) -> Self {
        var copy = self
        
        switch type {
        case .scrollView:
            copy.totalHeight = CGFloat.zero
            copy.layoutType = TagLayout.scrollView
        case .vstack:
            copy.totalHeight = CGFloat.infinity
            copy.layoutType = TagLayout.vstack
        }
        
        return copy
    }
    
    /// Change pading and spacing
    /// - Parameter paddingSize: CGFloat
    public func changePadding(spacing: CGFloat = 8, vPadding: CGFloat = 5, hPadding: CGFloat = 10) -> Self {
        var copy = self
        copy.spacing = spacing
        copy.vPadding = vPadding
        copy.hPadding = hPadding
        return copy
    }
    
    /// Change default tag color
    /// - Parameter colors: Color
    public func defaultColor(foreground: Color, background: Color) -> Self {
        var copy = self
        copy.foregroundColor = foreground
        copy.backgroundColor = background
        return copy
    }
    
    /// Change active tag color
    /// - Parameter colors: Color
    public func activeColor(foreground: Color, background: Color) -> Self {
        var copy = self
        copy.activeForegroundColor = foreground
        copy.activeBackgroundColor = background
        return copy
    }
}

struct TestTagCloudView : View {
    var body: some View {
        VStack {
            Text("Header").font(.largeTitle)
            TagCloudView(tags: ["Ninetendo", "XBox", "PlayStation", "PlayStation 2", "PlayStation 3", "PlayStation 4"], activeTag: .constant([1,2]))
            Text("Some other text")
            Text("Some other cloud")
            TagCloudView(tags: ["Apple", "Google", "Amazon", "Microsoft", "Oracle", "Facebook"], activeTag: .constant([2,4]))
        }
    }
}


struct TagCloudView_Previews: PreviewProvider {
    static var previews: some View {
        TestTagCloudView()
    }
}
