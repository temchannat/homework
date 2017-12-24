//
//  NoteDetailViewController.swift
//  Homework4 CoreData
//
//  Created by Channat Tem on 12/21/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func addButtonAction(_ sender: Any) {
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
