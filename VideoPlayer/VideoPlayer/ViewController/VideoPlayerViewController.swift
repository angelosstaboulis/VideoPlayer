//
//  VideoPlayerViewController.swift
//  VideoPlayer
//
//  Created by Angelos Staboulis on 22/4/21.
//

import UIKit
import AVKit
protocol VideoPlayerTableProtocol:AnyObject{
    func setupView()
    func setupCell(tableView:UITableView,indexPath:IndexPath)->VideoTableCell
    func initializeVideoPlayer()->AVPlayerLayer
}
class VideoPlayerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, VideoPlayerTableProtocol {
    var avItem:AVPlayerItem!
    var avPlayer:AVPlayer!
    var avLayer:AVPlayerLayer!
    let video = url_video
    @IBOutlet var mainTableView: UITableView!
     override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension VideoPlayerViewController{
    func setupView(){
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "VideoTableCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    func setupCell(tableView:UITableView,indexPath:IndexPath)->VideoTableCell{
        let cell:VideoTableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! VideoTableCell
        cell.backgroundColor = UIColor.black
        cell.btnPlay.tag = indexPath.row
        cell.btnPlay.addTarget(self, action: #selector(clickVideo(sender:)), for: .touchDown)
        return cell
    }
}
extension VideoPlayerViewController {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(660.0)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setupCell(tableView:tableView,indexPath: indexPath)
    }
    
    func initializeVideoPlayer()->AVPlayerLayer{
        avItem = AVPlayerItem(url: URL(string:video)!)
        avPlayer = AVPlayer(playerItem: avItem)
        avLayer = AVPlayerLayer(player: avPlayer)
        avLayer.bounds = CGRect(x: 0, y: 0, width: 1200, height: 600)
        return avLayer
     }
    @objc func stopVideo(sender:UIButton){
        let cell:VideoTableCell = mainTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! VideoTableCell
        cell.btnPlay.setTitle("Play", for: .normal)
        cell.btnPause.isHidden = true
        cell.btnPlay.isHidden = false
        avLayer.player?.rate = 0
        avLayer.player?.seek(to: CMTime.zero)
        avLayer.player?.pause()
        avLayer.player?.replaceCurrentItem(with: nil)
    }
    @objc func clickVideo(sender:UIButton){
        let cell:VideoTableCell = mainTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! VideoTableCell
        cell.btnPause.isHidden = false
        cell.btnPlay.isHidden = true
        cell.videoView.layer.addSublayer(initializeVideoPlayer())
        cell.btnPause.addTarget(self, action: #selector(stopVideo(sender:)), for: .touchDown)
    
        avPlayer.play()
        
        
    }
}
