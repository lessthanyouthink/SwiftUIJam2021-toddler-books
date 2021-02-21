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
            VStack {
                BookCover(cover: book.coverImage)
                    .frame(maxHeight: 200)
                Text(book.title!)
                    .font(.title)
                if let author = book.author {
                    Text("By \(author)")
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

struct BookDetails_Previews: PreviewProvider {
    static let book: Book = {
        let book = Book(context: PersistenceController.preview.container.viewContext)
        book.title = "This Is The Book"
        book.author = "S. Person"
        return book
    }()
    static var previews: some View {
        BookDetails(book: book)
    }
}
