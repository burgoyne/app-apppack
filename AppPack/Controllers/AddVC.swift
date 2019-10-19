//  Copyright © 2019 Andre Burgoyne. All rights reserved.

import UIKit

class AddVC: UIViewController, UITextViewDelegate {
    
    var previousVC = IdeaVC()
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var importantSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTxt.delegate = self
        textViewDesign()
        self.title = "New"
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func AddBtnPressed(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let idea = CoreIdea(entity: CoreIdea.entity(), insertInto: context)
            
            let today = Date()
            if let nameText = nameTxt.text {
                idea.name = nameText
                idea.desc = descriptionTxt.text!
                idea.date = today.DateString(dateFormat: "MM/dd/yyyy")
                idea.isImportant = importantSwitch.isOn
            }
            try? context.save()
            navigationController?.popViewController(animated: true)
        }
    }
    
    func textViewDesign() {
        nameTxt.layer.borderWidth = 1
        nameTxt.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        descriptionTxt.layer.borderWidth = 1
        descriptionTxt.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        descriptionTxt.text = " Describe your app idea"
        descriptionTxt.textColor = UIColor.white

        descriptionTxt.selectedTextRange = descriptionTxt.textRange(from: descriptionTxt.beginningOfDocument, to: descriptionTxt.beginningOfDocument)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText:String = descriptionTxt.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        if updatedText.isEmpty {
            descriptionTxt.text = " Describe your app idea"
            descriptionTxt.textColor = UIColor.white

            descriptionTxt.selectedTextRange = descriptionTxt.textRange(from: descriptionTxt.beginningOfDocument, to: descriptionTxt.beginningOfDocument)
        } else if descriptionTxt.textColor == UIColor.white && !text.isEmpty {
            descriptionTxt.textColor = #colorLiteral(red: 0.9098039216, green: 0.4509803922, blue: 0.6470588235, alpha: 1)
            descriptionTxt.text = text
        } else {
            return true
        }
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if descriptionTxt.textColor == UIColor.white {
                descriptionTxt.selectedTextRange = descriptionTxt.textRange(from: descriptionTxt.beginningOfDocument, to: descriptionTxt.beginningOfDocument)
            }
        }
    }
}
