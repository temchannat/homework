//
//  NoteDetailViewController.swift
//  Homework4 CoreData
//
//  Created by Channat Tem on 12/21/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var titleLabel: UITextView!
    @IBOutlet weak var contentLabel: UITextView!
    
    var noteTitle = "Title"
    var noteContent = "Content"
    var indexPath: Int?
    var isUpdate: Bool?
    
    var notes = [Note]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.delegate = self
        contentLabel.delegate = self
        
        titleLabel.text = noteTitle
        contentLabel.text = noteContent
        
        // set text color to lightGray for the beggining. it acts like a placeholder for the textViews
        if titleLabel.text.trimmingCharacters(in: .whitespaces) == "Title" {
            titleLabel.textColor = .lightGray
        }
        if contentLabel.text.trimmingCharacters(in: .whitespaces) == "Content" {
            contentLabel.textColor = .lightGray
        }
        
        if indexPath == nil {
            isUpdate = false
        } else {
            isUpdate = true
        }
        
    }
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
         // TODO: Check textView before edit
        if textView == titleLabel && titleLabel.text == "Title" {
            titleLabel.textColor = .black
            titleLabel.text = ""
        }
        if textView == contentLabel && contentLabel.text == "Content" {
            contentLabel.textColor = .black
            contentLabel.text = ""
        }
        return true
    }
    

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        // check textView if it is empty then reset textView
        if textView == titleLabel && titleLabel.text.isEmpty {
            titleLabel.textColor = .lightGray
            titleLabel.text = "Title"
        }
        if textView == contentLabel && contentLabel.text.isEmpty {
            contentLabel.textColor = .lightGray
            contentLabel.text = "Content"
        }
        return true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if self.isMovingFromParentViewController {
            // check if update
            if isUpdate! {
                notes = try! context.fetch(Note.fetchRequest())
                notes[indexPath!].title = titleLabel.text
                notes[indexPath!].content = contentLabel.text
                appDelegate.saveContext()
            }
            // Not Update
            else {
                let note = Note(context: context)
                note.title = titleLabel.text
                note.content = contentLabel.text
                appDelegate.saveContext()
            }
        }
    }
    
}


// interface
extension NoteDetailViewController {
    
    @IBAction func addButtonAction(_ sender: Any) {
        var alertController: UIAlertController {
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            // declare AlertAction labels
            let takePhoto = UIAlertAction(title: "Take photo", style: .default) { (action) in
                //print(" ===> Take photo")
            }
            let chooseImage = UIAlertAction(title: "Choose Image", style: .default) { (action) in
                //print(" ===> Choose Image")
            }
            let drawing = UIAlertAction(title: "Drawing", style: .default) { (action) in
                //print(" ===> Drawing")
            }
            let record = UIAlertAction(title: "Records", style: .default) { (action) in
                //print(" ===> Records")
            }
            let checkBox = UIAlertAction(title: "Checkbox", style: .default) { (action) in
                //print(" ===> Checkbox")
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                //print(" ===> Cancel")
            }
            
            // add AlertAction Model
            alert.addAction(takePhoto)
            alert.addAction(chooseImage)
            alert.addAction(drawing)
            alert.addAction(record)
            alert.addAction(checkBox)
            alert.addAction(cancel)
            
            return alert
        }
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func moreButtonAction(_ sender: Any) {
        var alertController: UIAlertController {
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            // declare AlertAction labels
            let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                //print(" ===> Delete")
            }
            let makeCopy = UIAlertAction(title: "Make a copy", style: .default) { (action) in
                //print(" ===> Make a copy")
            }
            let send = UIAlertAction(title: "Send", style: .default) { (action) in
                //print(" ===> Send")
            }
            let collaboration = UIAlertAction(title: "Collaborations", style: .default) { (action) in
                //print(" ===> Collaboration")
            }
            let label = UIAlertAction(title: "Labels", style: .default) { (action) in
                //print(" ===> Labes")
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                //print(" ===> Cancel")
            }
            
            // add AlertAction Model
            alert.addAction(delete)
            alert.addAction(makeCopy)
            alert.addAction(send)
            alert.addAction(collaboration)
            alert.addAction(label)
            alert.addAction(cancel)
            
            return alert
        }
        present(alertController, animated: true, completion: nil)
    }
    
}
