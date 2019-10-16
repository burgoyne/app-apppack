//  Copyright © 2019 Andre Burgoyne. All rights reserved.

import UIKit

class IdeaCell: UITableViewCell {
    
    @IBOutlet weak var ideaNameLbl: UILabel!
    @IBOutlet weak var ideaDateLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell(idea : CoreIdea) {
        let name = idea.name
        if idea.isImportant {
            ideaNameLbl.text = "❗️ " + name!
        } else {
            ideaNameLbl.text = name
        }
        
        
        let date = idea.date
        ideaDateLbl.text = date
    }
}

extension Date {
    func DateString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
