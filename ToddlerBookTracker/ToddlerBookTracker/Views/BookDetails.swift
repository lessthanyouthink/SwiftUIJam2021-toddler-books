//
//  BookDetails.swift
//  ToddlerBookTracker
//
//  Created by Charles Joseph on 2021-02-21.
//

import SwiftUI
import CoreData

struct BookDetails: View {
    @ObservedObject var book: Book

    var body: some View {
        ScrollView {
            HStack(spacing: 16) {
                BookCover(cover: book.coverImage)
                    .frame(maxHeight: 160)
                VStack(spacing: 4) {
                    Text(book.title!)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    if let author = book.author {
                        Text("By \(author)")
                            .font(.subheadline)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            Text("Cool")
        }
    }
}

struct BookDetails_Previews: PreviewProvider {
    static let book: Book? = {
        let request = NSFetchRequest<Book>(entityName: "Book")
        let books = try? PersistenceController.preview.container.viewContext.fetch(request)
        return books?.first
    }()
    static var previews: some View {
        BookDetails(book: book!)
    }
}
