//
//  RickyMortieTableViewCell.swift
//  RickyMortieAppSwiftWithoutSB
//
//  Created by ahmet azak on 6.08.2023.
//

import UIKit
import AlamofireImage

class RickyMortieTableViewCell: UITableViewCell {
 
     let customImage : UIImageView = UIImageView()
     let title : UILabel = UILabel ()
     let customDescription : UILabel = UILabel()
    
    private let randomImage = "https://picsum.photos/seed/picsum/200/300"
    enum Identifier : String {
        case custom = "vb10"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has been imlemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func configure ()
    {
     addSubview(customImage)
     addSubview(title)
     addSubview(customDescription)
        title.font = .boldSystemFont(ofSize: 18)
        customDescription.font = .boldSystemFont(ofSize: 10)
        customImage.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.top.equalTo(contentView)
            
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(customImage.snp.bottom).offset(10)
            make.right.left.equalTo(contentView)
      
            
        }
        customDescription.snp.makeConstraints { make in
            make.top.equalTo(title).offset(5)
            make.right.left.equalTo(title)
            make.bottom.equalToSuperview()
        }
    }
    func saveModel(model : Result) {
        title.text = model.name
        customDescription.text = model.status.rawValue
        customImage.af.setImage(withURL: URL(string: model.image) ?? URL(string: randomImage)!)
    }

}
