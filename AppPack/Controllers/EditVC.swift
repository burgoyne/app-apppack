//  Copyright © 2019 Andre Burgoyne. All rights reserved.

import UIKit

class EditVC: UIViewController, UITextViewDelegate {
    
    var previousVC = ViewVC()
    var ideaToEdit : CoreIdea? = nil
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var importantSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Update"
        descTextView.delegate = self
        textViewDesign()
        nameTxtField.text = ideaToEdit?.name
        descTextView.text = ideaToEdit?.desc
        importantSwitch.isOn = ideaToEdit?.isImportant ?? false
        self.hideKeyboardWhenTappedAround() 
    }
    
    @IBAction func updateBtnPressed(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            ideaToEdit?.name = nameTxtField.text
            ideaToEdit?.desc = descTextView.text
            ideaToEdit?.isImportant = importantSwitch.isOn

            try? context.save()
            popBack(3)
        }
    }
    
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
    func textViewDesign() {
        nameTxtField.layer.borderWidth = 1
        nameTxtField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        descTextView.layer.borderWidth = 1
        descTextView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        descTextView.selectedTextRange = descTextView.textRange(from: descTextView.beginningOfDocument, to: descTextView.beginningOfDocument)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        let currentText:String = descTextView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        if updatedText.isEmpty {
            descTextView.text = " Describe your app idea"
            descTextView.textColor = UIColor.white

            descTextView.selectedTextRange = descTextView.textRange(from: descTextView.beginningOfDocument, to: descTextView.beginningOfDocument)
        } else if descTextView.textColor == UIColor.white && !text.isEmpty {
            descTextView.textColor = #colorLiteral(red: 0.9098039216, green: 0.4509803922, blue: 0.6470588235, alpha: 1)
            descTextView.text = text
        } else {
            return true
        }
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if descTextView.textColor == UIColor.white {
                descTextView.selectedTextRange = descTextView.textRange(from: descTextView.beginningOfDocument, to: descTextView.beginningOfDocument)
            }
        }
    }
}
