//
//  VideoTableCell.swift
//  VideoPlayer
//
//  Created by Angelos Staboulis on 23/4/21.
//

import UIKit

class VideoTableCell: UITableViewCell {

    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var videoView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        createRoundedButton()
        // Initialization code
    }
    func createRoundedButton(){
        btnPause.isHidden = true
        btnPlay.layer.cornerRadius = btnPlay.bounds.height / 2
        btnPlay.layer.masksToBounds = true
        btnPause.layer.cornerRadius = btnPause.bounds.height / 2
        btnPause.layer.masksToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
