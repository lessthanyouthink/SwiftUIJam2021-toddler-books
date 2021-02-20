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
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.lastRead, ascending: false)],
        animation: .default
    )
    private var books: FetchedResults<Book>

    @State private var showingAddSheet = false

    var body: some View {
        List {
            ForEach(books) { book in
                HStack {
                    Image(systemName: "rectangle.portrait")
                        .font(.largeTitle)
                        .frame(width: 60, height: 60, alignment: .center)
                    VStack(alignment: .leading) {
                        Text(book.title ?? "Untitled")
                            .font(.headline)
                        if let author = book.author {
                            Text("by \(author)")
                                .font(.callout)
                        }
                        if let lastRead = book.lastRead {
                            Text("Last read: \(lastRead, formatter: dateFormatter)")
                                .font(.caption)
                        }
                    }
                    Spacer()
                    Button(action: {
                        withAnimation {
                            book.logReading(withContext: viewContext)
                        }
                    }, label: {
                        Image(systemName: "text.badge.checkmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(8)
                    })
                    .frame(maxWidth: 32, maxHeight: 32, alignment: .center)
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 2)
                    )
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
                }
                .padding([.trailing, .top, .bottom])
            }
        }
        .navigationTitle("Books")
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

private let dateFormatter: RelativeDateTimeFormatter = {
    let formatter = RelativeDateTimeFormatter()
    formatter.dateTimeStyle = .named    
    return formatter
}()

struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookList()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
