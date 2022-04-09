//
//  InformationTableViewCell.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 06.04.2022.
//

import UIKit

class InformationCell: UITableViewCell {

    @IBOutlet weak var fieldImage: UIImageView!
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var countryDetailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
