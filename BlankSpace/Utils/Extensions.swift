//
//  Extensions.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 14/10/21.
//

import Foundation
import SwiftUI

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
}

extension Color {
    static var appColorPrimary: Color {
        return Color("BGColor")
    }
    static var appColorGrey: Color {
        return Color("BackButtonGrey")
    }
    static var appColorDarkGrey: Color {
        return Color("DarkGreySlider")
    }
    static var appColorBlue: Color {
        return Color("AppColorBlue")
    }
    static var appColorGreen: Color {
        return Color("AppColorGreen")
    }
    static var appColorRed: Color {
        return Color("AppColorRed")
    }
    static var appColorPink: Color {
        return Color("AppColorPink")
    }
    static var appColorLightGrey: Color {
        return Color("LightGrey")
    }
}

extension Collection where Element: Equatable {
    
    func element(after element: Element, wrapping: Bool = false) -> Element? {
        if let index = self.firstIndex(of: element){
            let followingIndex = self.index(after: index)
            if followingIndex < self.endIndex {
                return self[followingIndex]
            } else if wrapping {
                return self[self.startIndex]
            }
        }
        return nil
    }
}

extension Array where Element: Equatable {
    func nextItem(after: Element) -> Element? {
        if let index = self.firstIndex(of: after), index + 1 < self.count {
            return self[index + 1]
        }
        return nil
    }
}

extension Color {
    var uiColor: UIColor? {
        if #available(iOS 14.0, *) {
            return UIColor(self)
        } else {
            let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
            var hexNumber: UInt64 = 0
            var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
            let result = scanner.scanHexInt64(&hexNumber)
            if result {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
                return UIColor(red: r, green: g, blue: b, alpha: a)
            } else {
                return nil
            }
        }
    }
}

extension View {
    func tabViewStyle(backgroundColor: Color? = nil,
                      itemColor: Color? = nil,
                      selectedItemColor: Color? = nil,
                      badgeColor: Color? = nil) -> some View {
        onAppear {
            let itemAppearance = UITabBarItemAppearance()
            if let uiItemColor = itemColor?.uiColor {
                itemAppearance.normal.iconColor = uiItemColor
                itemAppearance.normal.titleTextAttributes = [
                    .foregroundColor: uiItemColor
                ]
            }
            if let uiSelectedItemColor = selectedItemColor?.uiColor {
                itemAppearance.selected.iconColor = uiSelectedItemColor
                itemAppearance.selected.titleTextAttributes = [
                    .foregroundColor: uiSelectedItemColor
                ]
            }
            if let uiBadgeColor = badgeColor?.uiColor {
                itemAppearance.normal.badgeBackgroundColor = uiBadgeColor
                itemAppearance.selected.badgeBackgroundColor = uiBadgeColor
            }
            
            let appearance = UITabBarAppearance()
            if let uiBackgroundColor = backgroundColor?.uiColor {
                appearance.backgroundColor = uiBackgroundColor
            }
            
            appearance.stackedLayoutAppearance = itemAppearance
            appearance.inlineLayoutAppearance = itemAppearance
            appearance.compactInlineLayoutAppearance = itemAppearance
            
            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}
