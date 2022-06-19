//
//  AddBookView.swift
//  Bookworm
//
//  Created by Bouchedoub Rmazi on 6/5/2022.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    @State private var date = Date.now
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var hasValidAddress: Bool {
        if title.count < 5 || author.count < 10 || review.count < 5 {
            return false
        }
        if title.hasPrefix(" ") || author.hasPrefix(" ") || genre.hasPrefix(" ") || review.hasPrefix(" "){
            return false
        }

        return true
    }
    

    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                                    ForEach(genres, id: \.self) {
                                        Text($0)
                                    }
                                }
                }
                
                Section{
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                            Button("Save") {
                                // add the book
                                
                                let newBook = Book(context: moc)
                                newBook.id = UUID()
                                newBook.title = title
                                newBook.author = author
                                newBook.rating = Int16(rating)
                                newBook.genre = genre
                                newBook.review = review
                                //newBook.date = date
                                
                                try? moc.save()
                                dismiss()
                            }
                            .disabled(hasValidAddress == false)
                        }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
