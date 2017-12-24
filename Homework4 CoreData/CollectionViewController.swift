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
 
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var index: Int?

    var notes: [Note]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
      
        self.customConfiguration()

        let deleteGesture : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(deleteOnHold(gesture:)))
        deleteGesture.minimumPressDuration = 0.5
        deleteGesture.delegate = self as? UIGestureRecognizerDelegate
        deleteGesture.delaysTouchesBegan = true
        self.collectionView?.addGestureRecognizer(deleteGesture)
        
    
    }
    
    func fetchData() {
        notes = try? context.fetch(Note.fetchRequest())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchData()
        self.collectionView.reloadData()
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
        //print("==> \(indexPath.item)")
        let detailSegue = self.storyboard?.instantiateViewController(withIdentifier: "storyboardDetail") as! NoteDetailViewController
        detailSegue.noteTitle = notes[indexPath.item].title!
        detailSegue.noteContent = notes[indexPath.item].content!
        detailSegue.indexPath = indexPath.item

        self.navigationController?.pushViewController(detailSegue, animated: true)
        
    }
   
    @IBAction func barButtonClick(_ sender: Any) {
        performSegue(withIdentifier: "showNoteDetails", sender: nil)
    }
    
    
}

// Interface
extension CollectionViewController {
    
    func customConfiguration() {
    
        // Set cell to be equal and flexible to screen
        let cellLayout = UICollectionViewFlowLayout()
        let cellWidth = UIScreen.main.bounds.width / 2 - 8
        cellLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        cellLayout.minimumLineSpacing = 5
        cellLayout.minimumInteritemSpacing = 5
        cellLayout.itemSize = CGSize(width: cellWidth, height: 150)
        collectionView.collectionViewLayout = cellLayout
    }
    
    @objc func deleteOnHold(gesture: UILongPressGestureRecognizer) {
        if gesture.state != .ended {
            return
        }
        
        let gestureOn = gesture.location(in: self.collectionView)
        if let indexPath = self.collectionView.indexPathForItem(at: gestureOn){
            let confirmation = UIAlertController(title: "Are you sure to delete?", message: nil, preferredStyle: .actionSheet)
            let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                let deletedNote = self.notes[indexPath.item]
                self.context.delete(deletedNote)
                self.appDelegate.saveContext()
                self.fetchData()
                self.collectionView.reloadData()
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            confirmation.addAction(delete)
            confirmation.addAction(cancel)
            
            present(confirmation, animated: true)
        }
    }
    
}

