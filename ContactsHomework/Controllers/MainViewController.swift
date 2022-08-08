//
//  ContactControllers.swift
//  ContactsHomework
//
//  Created by Aida Moldaly on 03.06.2022.
//

import UIKit


class MainViewController: UIViewController {
    
    let noContactsLabel = UILabel()
    
    let tableView = UITableView()
    
    var contacts: [Contact] = [
        Contact.init(fullname: "Moldaly Aida", phoneNumber: "87002123966", image: "male.jpeg", gender: ""),
        Contact.init(fullname: "Margulan Ulpan", phoneNumber: "87778564564", image: "female.jpeg", gender: "")
    ] {
        didSet {
            if contacts.isEmpty {
                self.view.bringSubviewToFront(noContactsLabel)
            } else {
                self.view.bringSubviewToFront(tableView)
            }
        }
    }
    
    override func viewDidLoad() {
        super.loadView()
        
        view.addSubview(noContactsLabel)
        setUpConstraints()
        setupTableView()
        setUpNaviagtion()
        
    }
    
    // MARK: - Setup UITableView
    
    func setupTableView() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: "ContactsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Setup NavigationController
    
    func setUpNaviagtion() {
        navigationItem.title = "Contacts"
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddContact))
    }
    
    // MARK: - Selectors

    @objc func handleAddContact () {
        let controller = EditAndAddViewController()
        controller.addDelegate = self
        navigationController?.pushViewController(controller, animated: true)
    
    }
    
    func setUpConstraints() {
        noContactsLabel.translatesAutoresizingMaskIntoConstraints = false
        noContactsLabel.isHidden = false
        noContactsLabel.text = "No contacts"
        noContactsLabel.font = UIFont.boldSystemFont(ofSize: 20)
        noContactsLabel.textColor = .black
        
        noContactsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        noContactsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
    
    // MARK: - UITableViewDataSource, UITableViewDelegate

    extension MainViewController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            contacts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactsTableViewCell
            
            cell.contact = contacts[indexPath.row]
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            110
        }
        
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            true
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                contacts.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = DetailViewController()
            vc.image = UIImage(named: contacts[indexPath.row].image ?? "")
            vc.name = contacts[indexPath.row].fullname
            vc.number = contacts[indexPath.row].phoneNumber
            
            vc.deleteDelegate = self
            vc.editDelegate = self
            vc.cellIndex = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    // MARK: - UpdateTableView

extension MainViewController:  AddContactDelegate, DeleteContactDelegate, EditContactDelegate {
    
    func addContact(contact: Contact) {
        self.dismiss(animated: true) {
            self.contacts.append(contact)
            self.tableView.reloadData()
        }
    }
    
    func deleteContact(index: Int) {
        contacts.remove(at: index)
        tableView.reloadData()
    }
    
    func editContact(contact: Contact, index: Int) {
        self.contacts[index] = contact
        tableView.reloadData()
    }
}




