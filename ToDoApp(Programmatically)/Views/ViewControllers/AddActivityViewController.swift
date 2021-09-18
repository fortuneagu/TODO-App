//
//  AddActivityViewController.swift
//  ToDoApp(Programmatically)
//
//

import UIKit
import CoreData


protocol addNewActivityControllerDelegate: AnyObject {
  func saveTodo(_ item: TodoList)
}

class AddActivityViewController: UIViewController {
  
  var item:[TodoList]?
  var selectedCell: TodoList? = nil
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var delegate: addNewActivityControllerDelegate?
  
  lazy var titleLabel: UILabel = {
      let label = UILabel()
      label.text = "Title"
      label.font = UIFont(name: "Helvetica", size: 18)
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = UIFont.boldSystemFont(ofSize: 18)
      return label
    }()
  
  lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "Description"
    label.font = UIFont(name: "Helvetica", size: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 18)
    return label
  }()
  
  lazy var importanceLabel: UILabel = {
    let label = UILabel()
    label.text = "Importance"
    label.font = UIFont(name: "Helvetica", size: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 18)
    return label
  }()
  
  lazy var titleTextView: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.tintColor = UIColor(red: 0.29, green: 0.05, blue: 0.76, alpha: 1.00)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
        textField.layer.borderWidth = 0
        textField.layer.cornerRadius = 8
        return textField
  }()
  
  lazy var descriptionTextView: LeftPaddedTextField = {
      let textField = LeftPaddedTextField()
      textField.tintColor = UIColor(red: 0.29, green: 0.05, blue: 0.76, alpha: 1.00)
      textField.layer.borderColor = UIColor.lightGray.cgColor
      textField.translatesAutoresizingMaskIntoConstraints = false
      textField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
      textField.layer.borderWidth = 0
      textField.layer.cornerRadius = 8
      return textField
}()
  
  let toggleButton: UISwitch = {
    var toggle = UISwitch()
    toggle.isOn = true
    toggle.translatesAutoresizingMaskIntoConstraints = false
    toggle.setOn(true, animated: false)
    toggle = UISwitch(frame: CGRect(x: 150, y: 300, width: 0, height: 0))
    return toggle
  }()
  
  lazy var addButton: UIButton = {
    let button = UIButton()
    button.setTitle("Add New Activity", for: .normal)
    button.addTarget(self, action: #selector(didTapPopButton), for: .touchUpInside)
    button.backgroundColor = UIColor(red: 0.29, green: 0.05, blue: 0.76, alpha: 1.00)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont(name: "Helvetica", size: 18)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 8
    return button
  }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      if (selectedCell != nil) {
        titleTextView.text = selectedCell?.title
        descriptionTextView.text = selectedCell?.describe
        
        if selectedCell?.importance == "Important" {
          toggleButton.isOn = true
        } else {
          toggleButton.isOn = false
        }
      }
      view.backgroundColor = .white
      setupConstraint()
      title = "Add New Activity"
    }

  @objc func didTapPopButton() {
      
      if (selectedCell == nil) {
      let newListItem = TodoList(context: self.context)
      newListItem.title = titleTextView.text
      newListItem.describe = descriptionTextView.text
        
        if toggleButton.isOn == true {
          newListItem.importance = "Important"
        } else {
          newListItem.importance = "Not Important"
        }
      do{
        delegate?.saveTodo(newListItem)
        navigationController?.popViewController(animated: true)
      }
      } else {
      // To Edit and Update a cell
        do{
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoList")
      let results:NSArray = try context.fetch(request) as NSArray
      for result in results {
        let newListItem = result as! TodoList
        if(newListItem == selectedCell)
        {
          newListItem.title = titleTextView.text
          newListItem.describe = descriptionTextView.text
          if toggleButton.isOn == true {
            newListItem.importance = "Important"
          } else {
            newListItem.importance = "Not Important"
          }
          delegate?.saveTodo(newListItem)
          navigationController?.popViewController(animated: true)
        }
      }
    }
        catch {
          print("Unable to fetch data")
        }
      }
    }
  
  func setupConstraint() {
    
    view.addSubview(titleLabel)
    view.addSubview(descriptionLabel)
    view.addSubview(importanceLabel)
    view.addSubview(titleTextView)
    view.addSubview(descriptionTextView)
    view.addSubview(addButton)
    view.addSubview(toggleButton)
    
    let stack = UIStackView(arrangedSubviews: [importanceLabel, toggleButton])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .horizontal
    stack.distribution = .fillProportionally
    stack.spacing = 180
    view.addSubview(stack)
  
    NSLayoutConstraint.activate ([
      
    titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
    titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
    
    titleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
    titleTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
    titleTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
    titleTextView.heightAnchor.constraint(equalToConstant: 45),
      
    descriptionLabel.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 30),
    descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
    descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
      
    descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
    descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
    descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
    descriptionTextView.heightAnchor.constraint(equalToConstant: 45),
    
    addButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 50),
    addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
    addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
    addButton.heightAnchor.constraint(equalToConstant: 52)
      
    ])
    
    _ = stack.anchor(descriptionTextView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 16, bottomConstant: 0, rightConstant: -16, widthConstant: 0, heightConstant: 40)
  }
}

class LeftPaddedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
  }
