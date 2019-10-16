//  Copyright © 2019 Andre Burgoyne. All rights reserved.

import UIKit

class IdeaVC: UITableViewController {
    
    @IBOutlet var tableview: UITableView!
    
    var ideas : [CoreIdea] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        setNavStyles()
        setTableStyles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getIdeas()
    }
    
    func getIdeas() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let coreDataIdeas = try? context.fetch(CoreIdea.fetchRequest()) as? [CoreIdea] {
                let theIdeas = coreDataIdeas
                    ideas = theIdeas
                    tableView.reloadData()
            }
        }
    }
    
    func setNavStyles() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2126879096, green: 0.2239724994, blue: 0.265286684, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3254901961, green: 0.6941176471, blue: 0.7921568627, alpha: 1)
        
        self.title = "AppPack"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Menlo", size: 22)!, NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0.3254901961, green: 0.6941176471, blue: 0.7921568627, alpha: 1))]
        
        navigationController?.navigationBar.layer.shadowColor = #colorLiteral(red: 0.2126879096, green: 0.2239724994, blue: 0.265286684, alpha: 1)
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 4.0
        navigationController?.navigationBar.layer.shadowOpacity = 1.0
        navigationController?.navigationBar.layer.masksToBounds = false
    }
    
    func setTableStyles() {
        self.tableView.backgroundColor = #colorLiteral(red: 0.3230867386, green: 0.3421254754, blue: 0.3874129653, alpha: 1)
        self.tableview.separatorColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ideas.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ideaCell", for: indexPath) as? IdeaCell {
            let idea = ideas[indexPath.row]
            cell.configureCell(idea: idea)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = #colorLiteral(red: 0.3230867386, green: 0.3421254754, blue: 0.3874129653, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idea = ideas[indexPath.row]
        performSegue(withIdentifier: "moveToView", sender: idea)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddVC {
            addVC.previousVC = self
        }
        
        if let viewVC = segue.destination as? ViewVC {
            if let idea = sender as? CoreIdea {
                viewVC.selectedIdea = idea
                viewVC.previousVC = self
            }
        }
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
