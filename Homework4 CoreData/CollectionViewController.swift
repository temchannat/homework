//
//  ViewController.swift
//  Homework4 CoreData
//
//  Created by Channat Tem on 12/20/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import UIKit
import CoreData

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
 

    var notes: [Notes]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Set cell to be equal and flexible to screen
        let cellLayout = UICollectionViewFlowLayout()
        let cellWidth = UIScreen.main.bounds.width / 2 - 8
        cellLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        cellLayout.minimumLineSpacing = 5
        cellLayout.minimumInteritemSpacing = 5
        cellLayout.itemSize = CGSize(width: cellWidth, height: 150)
        collectionView.collectionViewLayout = cellLayout
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        //Save
//        let note = Notes(context: context)
//        note.title = "Title D"
//        note.content = "Content of D"
//        try? appDelegate.saveContext()
        
        
        // fetch
        notes = try? context.fetch(Notes.fetchRequest())
//        for note in notes! {
//            print("\(note.title!)")
//            print("\(note.content!)")
//        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! NoteCollectionViewCell
        
        cell.titleLabel.text = notes[indexPath.item].title
        cell.contentLabel.text = notes[indexPath.item].content
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("==> \(indexPath)")
        performSegue(withIdentifier: "showNoteDetails", sender: nil)
    }
    
    
    
    
    @IBAction func barButtonClick(_ sender: Any) {
        performSegue(withIdentifier: "showNoteDetails", sender: nil)
    }
    
    

}

