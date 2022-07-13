//
//  DocumentsContentView.swift
//  Bucket List
//
//  Created by Takasur Azeem on 06/07/2022.
//

import SwiftUI

struct DocumentsContentView: View {
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                let str = "Test Message"
                let url = FileManager.documentsDirectory.appendingPathComponent("message.txt")

                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}

struct DocumentsContentVIew_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsContentView()
    }
}
