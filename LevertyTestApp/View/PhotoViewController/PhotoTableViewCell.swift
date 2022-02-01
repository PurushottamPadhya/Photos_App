//
//  PhotoTableViewCell.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 26/1/22.
//

import UIKit

class PhotoTableViewCell: UITableViewCell{
    
    @IBOutlet weak var photoImgeView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    func configureCell(){
        self.backgroundColor = .cellBackGroundColor
        photoTitleLabel.textColor = .textTitleColor
    }

    func setupCell(photo: PhotoModel){
        
        if let img = photo.thumbnailURL{
            photoImgeView.loadFrom(URLAddress: img)
        }
        if let title = photo.title{
            photoTitleLabel.text = title
        }
    }
    
}
