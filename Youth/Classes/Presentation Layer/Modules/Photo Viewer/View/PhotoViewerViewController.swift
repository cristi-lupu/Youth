//
//  PhotoViewerViewController.swift
//  Youth
//
//  Created by Lupu Cristian on 16/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public final class PhotoViewerViewController: UIViewController {

    deinit {
        doubleTapGesture?.removeTarget(nil, action: nil)
        doubleTapGesture = nil

        oneTapGesture?.removeTarget(nil, action: nil)
        oneTapGesture = nil
    }

    // MARK: IBOutlets

    @IBOutlet weak private var scrollView: UIScrollView!

    // MARK: Output

    public var output: PhotoViewerViewOutput?

    // MARK: Private properties

    private weak var photoImageView: UIImageView?
    private weak var doubleTapGesture: UITapGestureRecognizer?
    private weak var oneTapGesture: UITapGestureRecognizer?

    // MARK: View Controller Life Cycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = view.frame.size
        scrollView.setZoomScale(scrollView.minimumZoomScale, animated: false)
        photoImageView?.frame = view.frame
        updateImageViewLayout()
    }

    // MARK: Actions

    @objc private func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        guard let imageView = photoImageView else {
            return
        }

        let pointInView = sender.location(in: imageView)

        let newZoomScale = scrollView.zoomScale > scrollView.minimumZoomScale
            ? scrollView.minimumZoomScale
            : scrollView.maximumZoomScale

        let width = view.frame.width / newZoomScale
        let height = view.frame.height / newZoomScale
        let x = pointInView.x - (width / 2.0)
        let y = pointInView.y - (height / 2.0)

        let rectToZoomTo = CGRect(x: x, y: y, width: width, height: height)

        scrollView.zoom(to: rectToZoomTo, animated: true)
    }

    @objc private func handleOneTap(_ sender: UITapGestureRecognizer) {

    }

}

extension PhotoViewerViewController {

    private func updateImageViewLayout() {
        guard let imageView = photoImageView else {
            return
        }

        guard let image = imageView.image else {
            centerImageView()
            return
        }

        let imageViewSize = imageView.frame.size
        let imageSize = image.size

        let realImageViewSize: CGSize

        if imageSize.width / imageSize.height > imageViewSize.width / imageViewSize.height {
            realImageViewSize = CGSize(width: imageViewSize.width,
                                       height: imageViewSize.width / imageSize.width * imageSize.height)
        } else {
            realImageViewSize = CGSize(width: imageViewSize.height / imageSize.height * imageSize.width,
                                       height: imageViewSize.height)
        }

        imageView.frame = CGRect(origin: CGPoint.zero,
                                 size: realImageViewSize)

        centerImageView()
    }

    private func centerImageView() {
        guard let imageView = photoImageView else {
            return
        }

        let boundsSize = view.frame.size
        var imageViewFrame = imageView.frame

        if imageViewFrame.size.width < boundsSize.width {
            imageViewFrame.origin.x = (boundsSize.width - imageViewFrame.size.width) / 2.0
        } else {
            imageViewFrame.origin.x = 0.0
        }

        if imageViewFrame.size.height < boundsSize.height {
            imageViewFrame.origin.y = (boundsSize.height - imageViewFrame.size.height) / 2.0
        } else {
            imageViewFrame.origin.y = 0.0
        }

        imageView.frame = imageViewFrame
    }

}

extension PhotoViewerViewController: UIScrollViewDelegate {

    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImageView()
    }

    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }

}

extension PhotoViewerViewController: PhotoViewerViewInput {
	
    public func setUpInitialState() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true

        scrollView.addSubview(imageView)

        self.photoImageView = imageView

        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.delegate = self

        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapGesture)

        let oneTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleOneTap(_:)))
        scrollView.addGestureRecognizer(oneTapGesture)

        self.doubleTapGesture = doubleTapGesture
        self.oneTapGesture = oneTapGesture
    }

}
