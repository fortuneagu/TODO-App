//
//  TodoViewController.swift
//  ToDoApp(Programmatically)
//
//

import UIKit
import CoreData

class TodoViewController: UIViewController {
  
  var selectedCell: TodoList? = nil
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var item:[TodoList]?
  
  lazy var todoTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(todoTableView)
    title = "Todo List"
    setupTableViewConstraint()
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(didTapAddActivityButton))
    todoTableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "Cell")
    fetchList()
  }
  
  func setupTableViewConstraint() {
    todoTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    todoTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
    todoTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
    todoTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
  }
  
  @objc func didTapAddActivityButton() {
    let viewControlller = AddActivityViewController()
    viewControlller.delegate = self
    navigationController?.pushViewController(viewControlller, animated: true)
      
  }
  func fetchList() {
    do {
      self.item = try context.fetch(TodoList.fetchRequest())
      DispatchQueue.main.async {
        self.todoTableView.reloadData()
      }
    }
    catch {
    }
  }
  
  func createItems(_ items: TodoList){
    do {
      try context.save()
      fetchList()
    }
    catch{
    }
  }
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.item?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TodoTableViewCell
    let list = self.item![indexPath.row]
    cell.configuration(viewModel: TodoViewModel(with: list))
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath ) {
    let viewController = AddActivityViewController()
    viewController.delegate = self
    let selectedCell: TodoList!
    selectedCell = item![indexPath.row]
    viewController.selectedCell = selectedCell
    tableView.deselectRow(at: indexPath, animated: true)
    navigationController?.pushViewController(viewController, animated: true)
  }
  override func viewDidAppear(_ animated: Bool) {
    todoTableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
      
      let itemToRemove = self.item![indexPath.row]
      self.context.delete(itemToRemove)
      do{
        try self.context.save()
      }
      catch {
      }
      self.fetchList()
    }
    return UISwipeActionsConfiguration(actions: [action])
  }
}

extension TodoViewController: addNewActivityControllerDelegate {
  func saveTodo(_ item: TodoList) {
    createItems(item)
  }
}
