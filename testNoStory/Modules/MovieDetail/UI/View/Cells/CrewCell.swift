//
//  CrewCell.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//

import UIKit

class CrewCell: UITableViewCell {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!{
        didSet{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 5
            flowLayout.minimumInteritemSpacing = 5
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.backgroundColor = Style.colorSystem.neutral.transparent
        }
    }
    @IBOutlet weak var lblTitle: UILabel!{
        didSet{
            configureLabel(label: lblTitle, withText: "", color: Style.colorSystem.neutral.white, fontSize: 22.0)
        }
    }
    
    var items: [Crew] = []
    let cellIdentifier = String(describing: CharacterCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        clipsToBounds = false
        // Configure the view for the selected state
    }
    
    func configureCell(items: [Crew], title: String){
        self.contentView.backgroundColor = Style.colorSystem.primary.blue0
        self.items = items
        self.lblTitle.text = title
        let nibCell = UINib(nibName: cellIdentifier, bundle: Bundle.main)
        collectionView.register(nibCell, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
}

extension CrewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
        cell.configureCell(crew: items[indexPath.row])
        return cell
    }
    
}

extension CrewCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115.0, height: 170.0)
    }
}
