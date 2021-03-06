//
//  SkillsVC.swift
//  Dailies
//
//  Created by Roberto Manese III on 11/1/18.
//  Copyright © 2018 jawnyawn. All rights reserved.
//

import UIKit

class SkillsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, AddSkillDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    var skills: [Skill] = []

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.title = "Skills / Habits"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let tempSkill = Skill()
        let tempSkill2 = Skill()
        tempSkill.name = "Drink Water"
        tempSkill2.name = "Push Ups"
        skills.append(tempSkill)
        skills.append(tempSkill2)

        let addSkillButton = UIBarButtonItem(title: "Add Skill", style: .plain, target: self, action: #selector(didTapAddSkillButton))
        self.navigationItem.rightBarButtonItem = addSkillButton

        self.view.backgroundColor = .green
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.configCollectionView()
        let nib = UINib(nibName: "SkillCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "skillcell")
    }

    func configCollectionView() {
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: 150, height: 150)
            layout.minimumLineSpacing = 16
            layout.minimumInteritemSpacing = 16
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.skills.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "skillcell", for: indexPath) as! SkillCell
        cell.configure(skill: self.skills[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let skill = self.skills[indexPath.row]
        let details = SkillDetailsVC(skill: skill)
        self.navigationController?.pushViewController(details, animated: false)
    }

    @objc func didTapAddSkillButton() {
        let addSkillVC = AddSkillVC()
        addSkillVC.delegate = self
        self.navigationController?.pushViewController(addSkillVC, animated: false)
    }

    func didCreateSkill(view: AddSkillVC, skill: Skill) {
        self.skills.append(skill)
        self.collectionView.reloadData()
    }

}
