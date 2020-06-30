//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  
  
  @IBOutlet weak var tableview: UITableView!
  public var selectedImage: UIImage?
  //  var imageDelegate: SelectedImageDelegate?
  var posts = MediaPostsHandler.shared
  var postsViewModel = MediaPostsViewModel.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTableView()
    
  }
  
  func setUpTableView() {
    // Set delegates, register custom cells, set up datasource, etc.
    posts.getPosts()
    tableview.delegate = self
    tableview.dataSource = self
    tableview.reloadData()
    
  }
  
  
  @IBAction func didPressCreateTextPostButton(_ sender: UIButton) {
    let textPost:Int = sender.tag
    newPost(caller: textPost)
  }
  
  @IBAction func didPressCreateImagePostButton(_ sender: UIButton) {
    //    presentImagePickerActionSheet()
    let picker = UIImagePickerController()
    picker.delegate = self
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
      picker.sourceType = .photoLibrary
      picker.modalPresentationStyle = .fullScreen
      present(picker, animated: true, completion: nil)
    }
  }
  
  //MARK: - TableView DataSource and Delegate methods.
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.mediaPosts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellItem = posts.mediaPosts[indexPath.row]
    let cell = postsViewModel.setUpTableViewCell(for: cellItem, in: tableView)
    return cell
  }
  
  //MARK: - Post Alert Controller
  func newPost(caller: Any){
    let postType:Int = caller as! Int
    let newPostAlertController = UIAlertController(title: self.selectedImage == nil ? "New Text Post" : "New Image Post", message: nil, preferredStyle: .alert)
    var usernameTextField = UITextField()
    newPostAlertController.addTextField { (usernameTF) in
      usernameTF.placeholder = "Enter UserName..."
      usernameTextField = usernameTF
    }
    var messageTextField = UITextField()
    newPostAlertController.addTextField { (messageTF) in
      messageTF.placeholder = "Enter Message..."
      messageTextField = messageTF
    }
    let postAction = UIAlertAction(title: "Post", style: .default) { (postAction) in
      guard let username = usernameTextField.text, !username.isEmpty,
        let text = messageTextField.text, !text.isEmpty else { self.presentErrorAlert(caller: postType); return }
      if postType == 1{
        guard let image = self.selectedImage else {self.presentErrorAlert(caller: 2); return}
        MediaPostsHandler.shared.addImagePost(username: username, textBody: text, selectedImage: image)
        self.selectedImage = nil
      }else{
        MediaPostsHandler.shared.addTextPost(username: username, textBody: text)
      }
      self.tableview.reloadData()
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    newPostAlertController.addAction(postAction)
    newPostAlertController.addAction(cancelAction)
    self.present(newPostAlertController, animated: true, completion: nil)
  }
  
  // Missing info error alert
  func presentErrorAlert(caller postType: Int) {
    _ = postType
    var title = ""
    var message = ""
    if postType == 0{
      title = "Missing info"
      message = "Did both text fields get filled out?"
    }else if postType == 1{
      title = "Missing info"
      message = "Did both text fields get filled out?\nand select a Image to Post?"
    }else if postType == 2{
      title = "Missing Photo"
      message = "Photo Returned NIL"
    }
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (Action) in
      self.newPost(caller: postType)
    }))
    self.present(alertController, animated: true, completion: nil)
  }
}//MARK: -End of Class

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      self.selectedImage = photo
      dismiss(animated: true, completion: nil)
    }
    newPost(caller: 1)
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
}

