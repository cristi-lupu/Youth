//
//  PhotosCollectionViewGridLayout.swift
//  PhotosCollectionViewGridLayout
//
//  Created by Eric Cerney on 7/21/14. // Updated for his needs. Cristian Lupu
//  Copyright (c) 2014 Eric Cerney. All rights reserved.
//

// swiftlint:disable all

import UIKit

private func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    // swiftlint:disable:next identifier_name
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

private func > <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    // swiftlint:disable:next identifier_name
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

// swiftlint:disable:next identifier_name
let PhotosCollectionViewGridElementKindSectionHeader = UICollectionView.elementKindSectionHeader
// swiftlint:disable:next identifier_name
let PhotosCollectionViewGridElementKindSectionFooter = UICollectionView.elementKindSectionFooter

@objc protocol PhotosCollectionViewGridLayoutDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout: UICollectionViewLayout,
                        imageSizeForItemAtIndexPath indexPath: IndexPath) -> CGSize

    @objc
    optional func collectionView(_ collectionView: UICollectionView,
                                 layout: UICollectionViewLayout,
                                 heightForHeaderInSection section: Int) -> Float

    @objc
    optional func collectionView(_ collectionView: UICollectionView,
                                 layout: UICollectionViewLayout,
                                 heightForFooterInSection section: Int) -> Float

    @objc
    optional func collectionView(_ collectionView: UICollectionView,
                                 layout: UICollectionViewLayout,
                                 insetForSection section: Int) -> UIEdgeInsets

    @objc
    optional func collectionView(_ collectionView: UICollectionView,
                                 layout: UICollectionViewLayout,
                                 insetForHeaderInSection section: Int) -> UIEdgeInsets

    @objc
    optional func collectionView(_ collectionView: UICollectionView,
                                 layout: UICollectionViewLayout,
                                 insetForFooterInSection section: Int) -> UIEdgeInsets

    @objc
    optional func collectionView(_ collectionView: UICollectionView,
                                 layout: UICollectionViewLayout,
                                 minimumInteritemSpacingForSection section: Int) -> Float
}

final class PhotosCollectionViewGridLayout: UICollectionViewLayout {
    // MARK: Private constants

    /// How many items to be union into a single rectangle
    private let unionSize = 20

    // MARK: Public Properties

    var columnCount: Int = 2 {
        didSet {
            invalidateIfNotEqual(oldValue as AnyObject, newValue: columnCount as AnyObject)
        }
    }

    var minimumColumnSpacing: Float = 10.0 {
        didSet {
            invalidateIfNotEqual(oldValue as AnyObject, newValue: minimumColumnSpacing as AnyObject)
        }
    }

    var minimumInteritemSpacing: Float = 10.0 {
        didSet {
            invalidateIfNotEqual(oldValue as AnyObject, newValue: minimumInteritemSpacing as AnyObject)
        }
    }

    var headerHeight: Float = 0.0 {
        didSet {
            invalidateIfNotEqual(oldValue as AnyObject, newValue: headerHeight as AnyObject)
        }
    }

    var footerHeight: Float = 0.0 {
        didSet {
            invalidateIfNotEqual(oldValue as AnyObject, newValue: footerHeight as AnyObject)
        }
    }

    var headerInset: UIEdgeInsets = .zero {
        didSet {
            invalidateIfNotEqual(NSValue(uiEdgeInsets: oldValue), newValue: NSValue(uiEdgeInsets: headerInset))
        }
    }

    var footerInset: UIEdgeInsets = .zero {
        didSet {
            invalidateIfNotEqual(NSValue(uiEdgeInsets: oldValue), newValue: NSValue(uiEdgeInsets: footerInset))
        }
    }

    var sectionInset: UIEdgeInsets = .zero {
        didSet {
            invalidateIfNotEqual(NSValue(uiEdgeInsets: oldValue), newValue: NSValue(uiEdgeInsets: sectionInset))
        }
    }

    // A dictionary that maps from the CollectionView's section [key] to the item-width of its elements [value]. (read-only)
    private(set) var itemWidthForSection: [Int: Float] = [:]

    // MARK: Private Properties

    private weak var delegate: PhotosCollectionViewGridLayoutDelegate? {
        return collectionView?.delegate as? PhotosCollectionViewGridLayoutDelegate
    }

    private var columnHeights = [Float]()
    private var sectionItemAttributes = [[UICollectionViewLayoutAttributes]]()
    private var allItemAttributes = [UICollectionViewLayoutAttributes]()
    private var headersAttribute = [Int: UICollectionViewLayoutAttributes]()
    private var footersAttribute = [Int: UICollectionViewLayoutAttributes]()
    private var unionRects = [CGRect]()

    // MARK: UICollectionViewLayout Methods

    override func prepare() {
        super.prepare()

        let numberOfSections = collectionView?.numberOfSections

        if numberOfSections == 0 {
            return
        }

        assert(delegate!.conforms(to: PhotosCollectionViewGridLayoutDelegate.self),
               "UICollectionView's delegate should conform to PhotosGridLayoutDelegate protocol")

        assert(columnCount > 0,
               "PhotosGridFlowLayout's columnCount should be greater than 0")

        // Initialize variables
        headersAttribute.removeAll(keepingCapacity: false)
        footersAttribute.removeAll(keepingCapacity: false)
        unionRects.removeAll(keepingCapacity: false)
        columnHeights.removeAll(keepingCapacity: false)
        allItemAttributes.removeAll(keepingCapacity: false)
        sectionItemAttributes.removeAll(keepingCapacity: false)

        for _ in 0..<columnCount {
            self.columnHeights.append(0)
        }

        // Create attributes
        var top: Float = 0
        var attributes: UICollectionViewLayoutAttributes

        itemWidthForSection.removeAll()

        for section in 0..<numberOfSections! {
            /*
             * 1. Get section-specific metrics (minimumInteritemSpacing, sectionInset)
             */
            var minimumInteritemSpacing: Float

            if let height = delegate?.collectionView?(collectionView!, layout: self, minimumInteritemSpacingForSection: section) {
                minimumInteritemSpacing = height
            } else {
                minimumInteritemSpacing = self.minimumInteritemSpacing
            }

            var sectionInset: UIEdgeInsets

            if let inset = delegate?.collectionView?(collectionView!, layout: self, insetForSection: section) {
                sectionInset = inset
            } else {
                sectionInset = self.sectionInset
            }

            let width = Float(collectionView!.frame.size.width - sectionInset.left - sectionInset.right)

            let itemWidth = floorf((width - Float(columnCount - 1) * Float(minimumColumnSpacing)) / Float(columnCount))

            self.itemWidthForSection[section] = itemWidth

            /*
             * 2. Section header
             */
            var headerHeight: Float

            if let height = delegate?.collectionView?(collectionView!,
                                                      layout: self,
                                                      heightForHeaderInSection: section) {
                headerHeight = height
            } else {
                headerHeight = self.headerHeight
            }

            var headerInset: UIEdgeInsets

            if let inset = delegate?.collectionView?(collectionView!,
                                                     layout: self,
                                                     insetForHeaderInSection: section) {
                headerInset = inset
            } else {
                headerInset = self.headerInset
            }

            top += Float(headerInset.top)

            if headerHeight > 0 {
                attributes = UICollectionViewLayoutAttributes(
                    forSupplementaryViewOfKind: PhotosCollectionViewGridElementKindSectionHeader,
                    with: IndexPath(item: 0, section: section)
                )

                attributes.frame = CGRect(
                    x: headerInset.left,
                    y: CGFloat(top),
                    width: collectionView!.frame.size.width - (headerInset.left + headerInset.right),
                    height: CGFloat(headerHeight)
                )

                headersAttribute[section] = attributes
                allItemAttributes.append(attributes)

                top = Float(attributes.frame.maxY) + Float(headerInset.bottom)
            }

            top += Float(sectionInset.top)

            for idx in 0..<columnCount {
                columnHeights[idx] = top
            }

            /*
             * 3. Section items
             */
            let itemCount = collectionView!.numberOfItems(inSection: section)

            var itemAttributes = [UICollectionViewLayoutAttributes]()

            // Item will be put into shortest column.
            for idx in 0..<itemCount {
                let indexPath = IndexPath(item: idx, section: section)
                let columnIndex = shortestColumnIndex

                let xOffset = Float(sectionInset.left) + Float(itemWidth + minimumColumnSpacing) * Float(columnIndex)

                let yOffset = columnHeights[columnIndex]

                let itemSize = delegate?.collectionView(collectionView!,
                                                        layout: self,
                                                        imageSizeForItemAtIndexPath: indexPath)

                var itemHeight: Float = 0.0

                if itemSize?.height > 0 && itemSize?.width > 0 {
                    itemHeight = Float(itemSize!.height) * itemWidth / Float(itemSize!.width)
                }

                attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

                attributes.frame = CGRect(x: CGFloat(xOffset),
                                          y: CGFloat(yOffset),
                                          width: CGFloat(itemWidth),
                                          height: CGFloat(itemHeight))
                itemAttributes.append(attributes)
                allItemAttributes.append(attributes)
                columnHeights[columnIndex] = Float(attributes.frame.maxY) + minimumInteritemSpacing
            }
            sectionItemAttributes.append(itemAttributes)
            /*
             * 4. Section footer
             */
            var footerHeight: Float
            let columnIndex = longestColumnIndex
            top = columnHeights[columnIndex] - minimumInteritemSpacing + Float(sectionInset.bottom)
            if let height = delegate?.collectionView?(collectionView!,
                                                      layout: self,
                                                      heightForFooterInSection: section) {
                footerHeight = height
            } else {
                footerHeight = self.footerHeight
            }
            var footerInset: UIEdgeInsets
            if let inset = delegate?.collectionView?(collectionView!,
                                                     layout: self,
                                                     insetForFooterInSection: section) {
                footerInset = inset
            } else {
                footerInset = self.footerInset
            }
            top += Float(footerInset.top)
            if footerHeight > 0 {
                attributes = UICollectionViewLayoutAttributes(
                    forSupplementaryViewOfKind: PhotosCollectionViewGridElementKindSectionFooter,
                    with: IndexPath(item: 0, section: section)
                )

                attributes.frame = CGRect(
                    x: footerInset.left,
                    y: CGFloat(top),
                    width: collectionView!.frame.size.width - (footerInset.left + footerInset.right),
                    height: CGFloat(footerHeight)
                )

                footersAttribute[section] = attributes
                allItemAttributes.append(attributes)

                top = Float(attributes.frame.maxY) + Float(footerInset.bottom)
            }

            for idx in 0..<columnCount {
                columnHeights[idx] = top
            }
        }

        // Build union rects
        var idx = 0
        let itemCounts = allItemAttributes.count

        while idx < itemCounts {
            let rect1 = allItemAttributes[idx].frame
            idx = min(idx + unionSize, itemCounts) - 1
            let rect2 = allItemAttributes[idx].frame
            unionRects.append(rect1.union(rect2))
            idx += 1
        }
    }

    override var collectionViewContentSize: CGSize {
        let numberOfSections = collectionView?.numberOfSections

        if numberOfSections == 0 {
            return CGSize.zero
        }

        guard !columnHeights.isEmpty else {
            return CGSize.zero
        }

        var contentSize = collectionView?.bounds.size
        contentSize?.height = CGFloat(columnHeights[0])

        return contentSize!
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if indexPath.section >= sectionItemAttributes.count {
            return nil
        }

        if indexPath.item >= sectionItemAttributes[indexPath.section].count {
            return nil
        }

        return sectionItemAttributes[indexPath.section][indexPath.item]
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String,
                                                       at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var attribute: UICollectionViewLayoutAttributes?

        if elementKind == PhotosCollectionViewGridElementKindSectionHeader {
            attribute = headersAttribute[indexPath.section]
        } else if elementKind == PhotosCollectionViewGridElementKindSectionFooter {
            attribute = footersAttribute[indexPath.section]
        }

        return attribute
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var begin: Int = 0
        var end: Int = unionRects.count
        var attrs = [UICollectionViewLayoutAttributes]()

        for i in 0..<end {
            if rect.intersects(unionRects[i]) {
                begin = i * unionSize
                break
            }
        }

        for i in (0..<end).reversed() {
            if rect.intersects(unionRects[i]) {
                end = min((i + 1) * unionSize, allItemAttributes.count)
                break
            }
        }

        for i in begin..<end {
            let attr = allItemAttributes[i]

            if rect.intersects(attr.frame) {
                attrs.append(attr)
            }
        }

        return Array(attrs)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let oldBounds = collectionView?.bounds
        if newBounds.width != oldBounds!.width {
            return true
        }
        return false
    }

    // MARK: Private Methods

    private var shortestColumnIndex: Int {
        var index: Int = 0
        var shortestHeight = MAXFLOAT

        for (idx, height) in columnHeights.enumerated() where height < shortestHeight {
            shortestHeight = height
            index = idx
        }

        return index
    }

    private var longestColumnIndex: Int {
        var index: Int = 0
        var longestHeight: Float = 0

        for (idx, height) in columnHeights.enumerated() where height > longestHeight {
            longestHeight = height
            index = idx
        }

        return index
    }

    private func invalidateIfNotEqual(_ oldValue: AnyObject, newValue: AnyObject) {
        if !oldValue.isEqual(newValue) {
            invalidateLayout()
        }
    }
}
