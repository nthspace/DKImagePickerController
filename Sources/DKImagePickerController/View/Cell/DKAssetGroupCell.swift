//
//  ImagePickerGroupTableViewCell.swift
//  bonbon
//
//  Created by Amdis Liu on 2019/5/20.
//  Copyright © 2019 jon. All rights reserved.
//

import UIKit
import Photos
//import DKImagePickerController

//@objc public protocol DKAssetGroupCellType {
//    static var preferredHeight: CGFloat { get }
//    func configure(with assetGroup: DKAssetGroup, tag: Int, dataManager: DKImageGroupDataManager, imageRequestOptions: PHImageRequestOptions)
//}

class DKAssetGroupCell: UITableViewCell, DKAssetGroupCellType {
    static var preferredHeight: CGFloat = 56
    

    @IBOutlet weak var tickIcon: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        tickIcon.isHidden = false
        groupName.font = UIFont(name: "PingFangTC-Medium", size: 15)
    }
    
    func configure(with assetGroup: DKAssetGroup, tag: Int, dataManager: DKImageGroupDataManager, imageRequestOptions: PHImageRequestOptions) {
        self.tag = tag
        groupName.text = assetGroup.groupName
        if assetGroup.totalCount == 0 {
            thumbnail.image = DKImagePickerControllerResource.emptyAlbumIcon()
        } else {
            dataManager.fetchGroupThumbnail(
                with: assetGroup.groupId,
                size: CGSize(width: 56, height: 56).toPixel(),
                options: imageRequestOptions) { [weak self] image, info in
                    if self?.tag == tag {
                        self?.thumbnail.image = image
                    }
            }
        }
    }
}
