//
//  DetailViewController.swift
//  ContactsHomework
//
//  Created by Aida Moldaly on 05.06.2022.
//

import UIKit

protocol DeleteContactDelegate: AnyObject {
    func deleteContact(index: Int)
}

class DetailViewController: UIViewController {
    
    var cellIndex: Int?

    weak var deleteDelegate: DeleteContactDelegate?
    weak var editDelegate: EditContactDelegate?
    
    let contactImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    var callButton: UIButton = {
        let button = UIButton()
        button.setTitle("Call", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .white
        return button
    }()
    
    var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(handleDeleteContact), for: .touchUpInside)
        return button
    }()
    
    var image: UIImage?
    var name: String?
    var number: String?
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(contactImageView)
        view.addSubview(fullNameLabel)
        view.addSubview(phoneNumberLabel)
        view.addSubview(deleteButton)
        view.addSubview(callButton)
        
        contactImageView.image = image
        fullNameLabel.text = name
        phoneNumberLabel.text = number
        
        setUpNaviagtion()
        setUpConstraints()
    }
    
    func setUpNaviagtion() {
        navigationItem.title = "Contact info"
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEditContact))
    }
    
    // MARK: - Edit

    @objc func handleEditContact () {

        let controller = EditAndAddViewController(name: name!, phoneNumber: number!)
        controller.editDelegate = editDelegate
        controller.cellIndex2 = cellIndex
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleDeleteContact() { 
        deleteDelegate?.deleteContact(index: cellIndex!)
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Setup Constraints
    
    func setUpConstraints() {
        contactImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        contactImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        contactImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        contactImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        fullNameLabel.topAnchor.constraint(equalTo: contactImageView.topAnchor).isActive = true
        fullNameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 30).isActive = true
        fullNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        
        phoneNumberLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 10).isActive = true
        phoneNumberLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor).isActive = true
        phoneNumberLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor, constant: -10).isActive = true
        
        
        callButton.leadingAnchor.constraint(equalTo: contactImageView.leadingAnchor).isActive = true
        callButton.trailingAnchor.constraint(equalTo: phoneNumberLabel.trailingAnchor).isActive = true
        callButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        callButton.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -10).isActive = true

        
        deleteButton.leadingAnchor.constraint(equalTo: contactImageView.leadingAnchor).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: phoneNumberLabel.trailingAnchor).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        
    }
}


