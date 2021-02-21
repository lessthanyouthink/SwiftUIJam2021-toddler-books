//
//  BookListCell.swift
//  ToddlerBookTracker
//
//  Created by Charles Joseph on 2021-02-21.
//

import SwiftUI

struct BookListCell: View {
    @ObservedObject var book: Book

    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        HStack {
            BookCover(cover: book.coverImage)
                .frame(width: 60, height: 60, alignment: .center)
                .padding([.leading, .trailing], 8)
            VStack(alignment: .leading) {
                Text(book.title ?? "Untitled")
                    .font(.headline)
                if let author = book.author {
                    Text("by \(author)")
                        .font(.callout)
                }
                if let dateLastRead = book.dateLastRead {
                    Text("Last read: \(dateLastRead, formatter: dateFormatter)")
                        .font(.caption)
                }
            }
            Spacer()
            Button(action: {
                withAnimation {
                    book.logReading()
                }
            }, label: {
                Image(systemName: "text.badge.checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
            })
            .frame(maxWidth: 32, maxHeight: 32, alignment: .center)            
            .buttonStyle(CapsuleButtonStyle())            
        }
    }
}

struct BookListCell_Previews: PreviewProvider {
    static let book: Book = {
        let book = Book(context: PersistenceController.preview.container.viewContext)
        book.title = "This Is The Book"
        book.author = "S. Person"
        return book
    }()

    static var previews: some View {
        BookListCell(book: book)
    }
}

private let dateFormatter: RelativeDateTimeFormatter = {
    let formatter = RelativeDateTimeFormatter()
    formatter.dateTimeStyle = .named
    return formatter
}()
