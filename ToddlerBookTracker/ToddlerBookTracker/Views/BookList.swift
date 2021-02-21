//
//  BookList.swift
//  ToddlerBookTracker
//
//  Created by Charles Joseph on 2021-02-19.
//

import SwiftUI
import CoreData

struct BookList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.sortDate, ascending: false)],
        animation: .default
    )
    private var books: FetchedResults<Book>

    @State private var showingAddSheet = false

    var body: some View {
        List {
            ForEach(books) { book in
                NavigationLink(destination: BookDetails(book: book)) {
                    BookListCell(book: book)
                        .padding([.vertical, .trailing])
                }
            }
        }
        .navigationTitle("Our Books")
        .toolbar {
            ToolbarItemGroup {
                Button(action: {
                    showingAddSheet = true
                }) {
                    Label("Add Book", systemImage: "plus.square.fill")
                }
            }
        }
        .sheet(isPresented: $showingAddSheet) {
            NavigationView {
                AddBookView(isPresented: $showingAddSheet)
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
}

struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookList()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}

// MARK: -

struct BookCover: View {
    let cover: UIImage?

    var body: some View {
        if let cover = cover {
            Image(uiImage: cover)
                .resizable()
                .aspectRatio(contentMode: .fit)                   
        }
        else {
            Image(systemName: "text.book.closed")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(6)
        }
    }
}
