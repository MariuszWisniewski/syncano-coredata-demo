//
//  ViewController.swift
//  syncano-coredata-demo
//
//  Created by Mariusz Wisniewski on 9/26/15.
//  Copyright (c) 2015 Mariusz Wisniewski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    let syncano = Syncano.sharedInstanceWithApiKey("3d1f307cbe1f65c1f9cea9e796fb2b9ec2e8284b", instanceName: "syncano-demo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addToTextView(text: String) {
        self.textView?.text = self.textView?.text.stringByAppendingString("\(text)\n\n")
        println(text)
        if let length = self.textView?.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) {
            if (length > 0 ) {
                let bottom = NSMakeRange(length - 1, 1)
                self.textView?.scrollRangeToVisible(bottom)
            }
        }
    }
}

//MARK: UI Handling
extension ViewController {
    @IBAction func downloadBooksPressed(sender: UIButton) {
        self.downloadBooks()
    }
    
    @IBAction func downloadAuthorsPressed(sender: UIButton) {
        self.downloadAuthors()
    }
    
    @IBAction func displayFromDatabasePressed(sender: UIButton) {
        let authorEntities = AuthorEntity.MR_findAll()
        let bookEntities = BookEntity.MR_findAll()
        for authorEntity in AuthorEntity.MR_findAll() as! [AuthorEntity] {
            self.addToTextView("Author: \(authorEntity.firstName) \(authorEntity.lastName)")
        }
//
        for bookEntity in BookEntity.MR_findAll() as! [BookEntity] {
            self.addToTextView("Book: \(bookEntity.title) by \(bookEntity.numberOfPages) \(bookEntity.author?.firstName) \(bookEntity.author?.lastName)")
//            self.addToTextView("Book: \(bookEntity.title) - \(bookEntity.numberOfPages) by ")
        }
    }
}

//MARK: Syncano Extension
extension ViewController {
    func downloadBooks() {
        self.addToTextView("Downloading books...")
        Book.please().giveMeDataObjectsWithCompletion { books, error in
            self.addToTextView("Downloaded books. Saving...")
            self.saveBooksToDatabase(books as! [Book])
        }
    }
    
    func downloadAuthors() {
        self.addToTextView("Downloading authors...")
        Author.please().giveMeDataObjectsWithCompletion { authors, error in
            self.addToTextView("Downloaded authors. Saving...")
            self.saveAuthorsToDatabase(authors as! [Author])
        }
    }
    
    func saveBooksToDatabase(books: [Book]) {
        MagicalRecord.saveWithBlock({ context in
            for book in books {
                BookEntity.createOrUpdateWithBook(book, inContext: context)
            }
            }, completion: { success, error in
                self.addToTextView("Downloaded and saved Books.")
        })
    }
    
    func saveAuthorsToDatabase(authors: [Author]) {
        MagicalRecord.saveWithBlock({ context in
            for author in authors {
                AuthorEntity.createOrUpdateWithAuthor(author, inContext: context)
            }
            }, completion: { success, error in
                self.addToTextView("Downloaded and saved Authors.")
        })
    }
}

