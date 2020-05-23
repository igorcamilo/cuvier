//
//  StatusTableViewCell.swift
//  Cuvier-iOS
//
//  Created by Igor Camilo on 23.05.20.
//  Copyright © 2020 Igor Camilo. All rights reserved.
//

import SwiftUI
import UIKit

class StatusTableViewCell: UITableViewCell {

    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    private func initialize() {
        contentView.addSubview(contentLabel)
        contentLabel.topAnchor.constraint(
            equalTo: contentView.readableContentGuide.topAnchor).isActive = true
        contentLabel.bottomAnchor.constraint(
            equalTo: contentView.readableContentGuide.bottomAnchor).isActive = true
        contentLabel.leadingAnchor.constraint(
            equalTo: contentView.readableContentGuide.leadingAnchor).isActive = true
        contentLabel.trailingAnchor.constraint(
            equalTo: contentView.readableContentGuide.trailingAnchor).isActive = true
    }

    required init?(coder: NSCoder) { nil }
}

#if DEBUG

struct StatusCell_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview(StatusTableViewCell(style: .default, reuseIdentifier: nil)) {
            $0.contentLabel.text = """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi tempor risus id est luctus vulputate. Maecenas nec semper ipsum, in fermentum lorem. Etiam vitae massa aliquet, rutrum urna sed, viverra dui. Etiam eu mattis magna, a vehicula metus. Praesent ullamcorper accumsan tristique. Donec commodo tincidunt mi, placerat iaculis risus dictum non.
            """
        }
        .previewLayout(.fixed(width: 400, height: 200))
    }
}

#endif
