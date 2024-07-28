//
//  ListView.swift
//  ImagesSearchApp
//
//  Created by Владимир Сеньков on 27.07.24.
//

import SwiftUI

struct ListView: View {
    @State private var userText: String = ""
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
                        TextField("Поиск",
                                  text: $userText,
                                  onCommit: { viewModel.searchImages(keyWord: userText) })
                        .textFieldStyle(.plain)
                        .disableAutocorrection(true)
                    }
                    .padding(.leading, 15)
                }
                .padding([.horizontal, .top], 20)
                
                List(viewModel.searchResponse?.photos ?? [], id: \.id) { image in
                    NavigationLink(destination: DetailView(imageString: image.src.large2X,
                                                           description: image.alt,
                                                           photographer: image.photographer)) {
                        HStack(spacing: 20) {
                            AsyncImage(url: URL(string: image.src.small)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 60, height: 60)
                            Text(image.alt)
                                .font(.headline)
                                .fontDesign(.monospaced)
                                .foregroundColor(.blue)
                        }
                    }
                }
                .listStyle(.plain)
                .padding(.vertical, 20)
                .padding()
            }
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text("Ошибка"),
                  message: Text("Что-то пошло не так.\n Попробуйте позже."),
                  dismissButton: .default((Text("Ok"))))
        }
        .onChange(of: userText) { newValue, _ in
            if newValue.isEmpty {
                viewModel.searchResponse = nil
            } else {
                viewModel.searchImages(keyWord: newValue)
            }
        }
    }
}
