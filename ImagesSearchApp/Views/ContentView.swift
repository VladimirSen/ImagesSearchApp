//
//  ContentView.swift
//  ImagesSearchApp
//
//  Created by Владимир Сеньков on 27.07.24.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            GridView()
                .tabItem {
                    Image("grid")
                    Text("Grid")
                }
                .tag(1)
            ListView()
                .tabItem {
                    Image("list")
                    Text("List")
                }
                .tag(2)
        }
    }
}
