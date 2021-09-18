//
//  TodoTableViewCell.swift
//  ToDoApp(Programmatically)
//
//

import UIKit

class TodoTableViewCell: UITableViewCell {
  
  lazy var titleLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = UIFont.boldSystemFont(ofSize: 30)
      return label
    }()
  
  lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: "Helvetica", size: 18)
    return label
  }()
  
  lazy var indicator: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.contentMode = .scaleAspectFit
    image.image = UIImage(named: "info")
    return image
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(titleLabel)
    addSubview(descriptionLabel)
    addSubview(indicator)
    cellConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configuration(viewModel: TodoViewModel) {
    titleLabel.text = viewModel.title
    descriptionLabel.text = viewModel.describe
    if viewModel.importance == "Important" {
      indicator.image = viewModel.image
    } else {
      indicator.image = nil
    }
  }
  
  func cellConstraints() {
    
    let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.distribution = .fillProportionally
    stack.spacing = 3
    addSubview(stack)
  
    _ = stack.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    
    
    NSLayoutConstraint.activate([
    
      indicator.topAnchor.constraint(equalTo: topAnchor, constant: 20),
      indicator.heightAnchor.constraint(equalToConstant: 30),
      indicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
      
    ])
  }
}
extension UIView {
  
  func anchorToTop(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil) {
    
    anchorWithConstantsToTop(top: top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
  }
  
  func anchorWithConstantsToTop(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0) {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
    }
    
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
    }
    
    if let left = left {
      leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
    }
    
    if let right = right {
      rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true
    }
    
  }
  
  func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
    translatesAutoresizingMaskIntoConstraints = false
    
    var anchors = [NSLayoutConstraint]()
    
    if let top = top {
      anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
    }
    
    if let left = left {
      anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
    }
    
    if let bottom = bottom {
      anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
    }
    
    if let right = right {
      anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
    }
    
    if widthConstant > 0 {
      anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
    }
    

    if heightConstant > 0 {
      anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
    }
    
    anchors.forEach({$0.isActive = true})
    
    return anchors
  }
  
  
}


