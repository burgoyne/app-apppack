//  Copyright © 2019 Andre Burgoyne. All rights reserved.

import UIKit

class ViewVC: UIViewController {
    
    var previousVC = IdeaVC()
    var selectedIdea : CoreIdea? = nil
    
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewStyles()
    }
    
    func viewStyles() {
        self.title = "Idea"
        
        nameTxt.text = selectedIdea?.name
        descriptionTxt.text = selectedIdea?.desc
        
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        backgroundView.layer.shadowColor = #colorLiteral(red: 0.2126879096, green: 0.2239724994, blue: 0.265286684, alpha: 1)
        backgroundView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        backgroundView.layer.shadowRadius = 4.0
        backgroundView.layer.shadowOpacity = 1.0
        backgroundView.layer.masksToBounds = false
    }
    
    @IBAction func removeBtnPressed(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let theIdea = selectedIdea {
                context.delete(theIdea)
                try? context.save()
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "moveToEdit", sender: selectedIdea)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editVC = segue.destination as? EditVC {
            if let idea = selectedIdea {
                editVC.ideaToEdit = idea
                editVC.previousVC = self
            }
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
}
