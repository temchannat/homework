//
//  NoteCollectionViewCell.swift
//  Homework4 CoreData
//
//  Created by Channat Tem on 12/20/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var noteViewContainer: UIView!
    
    override func awakeFromNib() {
        self.noteViewContainer.backgroundColor = UIColor.white
        self.noteViewContainer.layer.borderWidth = 1
        self.noteViewContainer.layer.cornerRadius = 5
    }
    
}
