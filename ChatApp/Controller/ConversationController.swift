//
//  ConversationController.swift
//  ChatApp
//
//  Created by Tamirlan Aubakirov on 15.08.2022.
//

import UIKit

private let reuseIdentifier = "ConversationCell"

class ConversationController: UIViewController {
   
    
    
    private let tableView = UITableView()
    
    
    
    // MARK: - Properties
    
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    // MARK: - Selectors
    
    
    @objc func showProfile(){
        print("123")
    }
    
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        view.backgroundColor = .white
        configureNavigationBar()
        configureTableView()
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain,
                                                           target: self, action: #selector(showProfile))
        
    }
    
    func configureTableView() {
        
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        
    }
    
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .purple
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Messages"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        
        
    }
    
    
}

// MARK: - UITableViewDelegate



extension ConversationController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}


// MARK: - UITableViewDataSource


extension ConversationController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = "TEST CELL"
        cell.backgroundColor = .white
        return cell
    }
}
