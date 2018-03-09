//
//  FeedController.swift
//  FacebookApplication
//
//  Created by Chandler Long on 3/8/18.
//  Copyright © 2018 Chandler Long. All rights reserved.
//

import UIKit

class Post {
    var name: String?
    var statusText: String?
    var profileImageName: String?
    var numLikes: Int?
    var numComments: Int?
    var statusImageName: String?
    
}

let cellId = "cellId"

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var alexPost = Post()
        
        var dennisPost = Post()
        dennisPost.name = "Dennis Reynolds"
        dennisPost.statusText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        dennisPost.profileImageName = "dennis"
        
        var macPost = Post()
        macPost.name = "Mac McDonald"
        macPost.statusText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        macPost.profileImageName = "mac"
        
        var charliePost = Post()
        charliePost.name = "Charlie Reynolds"
        charliePost.statusText = "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
        charliePost.profileImageName = "charlie"
        
        posts.append(dennisPost)
        posts.append(charliePost)
        posts.append(macPost)
        
        navigationItem.title = "News Feed"
        let image = UIImage(named: "direct_message")
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        feedCell.post = posts[indexPath.item]
        
        return feedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        //Getting the height of the string
        if let statusText = posts[indexPath.item].statusText {
            
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)], context: nil)
            
            let knownHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
            
            return CGSize(width: view.frame.width, height: rect.height + knownHeight + 30)
        }
        
        return CGSize(width: view.frame.width, height: 500)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

class FeedCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            
            if let name = post?.name {
                let attributeText = NSMutableAttributedString(string: name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
                attributeText.append(NSAttributedString(string: "\nDecember 18  ‌•  Philadelphia, PA  •", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor(r: 155, g: 161, b: 161)]))
                
                UIColor(r: 155, g: 161, b: 161)
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                
                attributeText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributeText.string.characters.count))
                
                nameLabel.attributedText = attributeText
            }
            
            if let statusText = post?.statusText {
                statusTextView.text = statusText
            }
            
            if let profileImageName  = post?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "dennis")
        
        return imageView
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = "I am the golden god"
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PBXXTests")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let likesCommentLabel: UILabel = {
        let label = UILabel()
        label.text = "234 Likes • 24 Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(r: 155, g: 161, b: 161)
        return label
    }()
    
    let dividerLine: UIView = {
        let divider = UIView()
        divider.backgroundColor = UIColor(r: 226, g: 228, b: 232)
        return divider
        
    }()
    
    let likeButton = FeedCell.buttonForTitle(title: "Like", imageName: "like")
    let dislikeButton: UIButton = FeedCell.buttonForTitle(title: "Dislike", imageName: "dislike")
    let commentButton: UIButton = FeedCell.buttonForTitle(title: "Comment", imageName: "comment")
    
    static func buttonForTitle(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor(r: 143, g: 150, b: 163), for: .normal)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }
    
    func setUpViews() {
        backgroundColor = UIColor.white
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentLabel)
        addSubview(dividerLine)
        addSubview(likeButton)
        addSubview(dislikeButton)
        addSubview(commentButton)
        
        addConstraintsWithFormat("H:|-8-[v0(44)]-12-[v1]|", views: profileImageView, nameLabel)
        
        addConstraintsWithFormat("H:|-4-[v0]-4-|", views: statusTextView)
        
        addConstraintsWithFormat("H:|[v0]|", views: statusImageView)
        
        addConstraintsWithFormat("H:|-12-[v0]|", views: likesCommentLabel)
        
        addConstraintsWithFormat("H:|-12-[v0]-12-|", views: dividerLine)
        
        //Button Constraints
        addConstraintsWithFormat("H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, dislikeButton, commentButton)
        
        addConstraintsWithFormat("V:|-12-[v0]", views: nameLabel)
        
        addConstraintsWithFormat("V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.4)]-8-[v5(44)]|", views: profileImageView, statusTextView, statusImageView, likesCommentLabel, dividerLine, likeButton)
        addConstraintsWithFormat("V:[v0(44)]|", views: dislikeButton)
        addConstraintsWithFormat("V:[v0(44)]|", views: commentButton)
        
    }
}

extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

