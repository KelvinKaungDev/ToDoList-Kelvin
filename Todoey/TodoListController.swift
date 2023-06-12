import UIKit

class TodoListController: UITableViewController {
    var lists = ["Eating", "Showering", "Studying"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let list = defaults.array(forKey: Constant.toDoList) {
            lists = list as! [String]
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath)
        cell.textLabel?.text = lists[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addList(_ sender: UIBarButtonItem) {
        var doLists = UITextField()
        let alert = UIAlertController(title: "Add To Do List", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.lists.append(doLists.text!)
            self.defaults.set(self.lists, forKey: Constant.toDoList)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (n) in
            n.placeholder = "Add To Do List"
            doLists = n
        }
        
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}

