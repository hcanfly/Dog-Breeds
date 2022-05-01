//
//  BreedCollectionViewCell.swift
//  DogBreeds
//
//  Created by Gary Hanson on 2/27/22.
//

import UIKit


final class BreedCollectionViewCell: UICollectionViewCell {
    static let identifier = "BreedCollectionViewCell"
    
    let cellImageView: AsyncCachedImageView = {
        let iv = AsyncCachedImageView(frame: CGRect.zero, urlString: nil)
        
        iv.clipsToBounds = true
        iv.contentMode = .scaleToFill
        iv.isUserInteractionEnabled = false
        
        return iv
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()

        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.isUserInteractionEnabled = false
        return label
    }()

    override init(frame: CGRect) {
            super.init(frame: frame)

        self.contentView.addSubview(cellImageView)
        self.contentView.addSubview(titleLabel)
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    override func layoutSubviews() {
        let contentFrame = bounds.inset(by: UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0))
        
        var imageFrame = contentFrame
        imageFrame.size = CGSize(width: imageFrame.width, height: imageFrame.height * 0.65)
        cellImageView.frame = imageFrame
        
        var labelFrame = contentFrame
        labelFrame = labelFrame.offsetBy(dx: 0, dy: labelFrame.height * 0.65)
        labelFrame.size = CGSize(width: labelFrame.width, height: labelFrame.height * 0.35)
        titleLabel.frame = labelFrame
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        cellImageView.image = nil
    }
    
}
