//
//  GridView.swift
//  ImagesSearchApp
//
//  Created by Владимир Сеньков on 27.07.24.
//

import SwiftUI

struct GridView: View {
    @State private var userText: String = ""
    @FocusState private var isFocused: Bool
    private var columns: [GridItem] = [
        .init(.fixed(180)),
        .init(.fixed(180))
    ]
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .frame(height: 30)
                        .cornerRadius(8)
                        .foregroundColor(.gray)
                        .opacity(0.2)
                    
                    HStack {
                        Image("search")
                        TextField("Поиск", text: $userText)
                            .textFieldStyle(.plain)
                            .focused($isFocused)
                            .disableAutocorrection(true)
                    }
                    .padding(.leading, 15)
                }
                .padding([.horizontal, .top], 20)
                Button {
                    viewModel.searchImages(keyWord: userText)
                    isFocused = false
                }
            label: {
                Text("Поиск")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
            .frame(width: 150, height: 30, alignment: .center)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.vertical, 10)
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.searchResponse?.photos ?? [], id: \.id) { image in
                            NavigationLink(destination: DetailView(imageString: image.src.large2X,
                                                                   description: image.alt,
                                                                   photographer: image.photographer)) {
                                ZStack {
                                    ImageView(urlString: image.src.tiny)
                                        .frame(width: 180, height: 120)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 20)
                .padding()
            }
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text("Ошибка"),
                      message: Text("Что-то пошло не так.\n Попробуйте позже."),
                      dismissButton: .default((Text("Ok"))))
            }
        }
    }
}
