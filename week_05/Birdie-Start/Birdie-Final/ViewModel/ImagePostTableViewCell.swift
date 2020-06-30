//
//  ImagePostTableViewCell.swift
//  Birdie-Final
//
//  Created by Alex Lundquist on 6/28/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ImagePostTableViewCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var timestampLabel: UILabel!
  @IBOutlet weak var textBodyLabel: UILabel!
  @IBOutlet weak var postImageView: UIImageView!
  
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
