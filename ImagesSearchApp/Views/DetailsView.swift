//
//  DetailsView.swift
//  ImagesSearchApp
//
//  Created by Владимир Сеньков on 27.07.24.
//

import SwiftUI

struct DetailView: View {
    @State var imageString: String
    @State var description: String
    @State var photographer: String
    @State var imageShareString: String
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageString)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 240)
            HStack(spacing: 10) {
                Text("Photographer:")
                Text(photographer)
                    .font(.title3)
            }
            .fontDesign(.monospaced)
            .padding(10)
        }
        .navigationBarTitle(Text(description), displayMode: .inline)
        .navigationBarItems(trailing: ShareLink("", item: imageShareString))
    }
}
