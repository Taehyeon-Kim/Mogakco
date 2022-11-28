//
//  Pager.swift
//  Mogakco
//
//  Created by taekki on 2022/11/28.
//

import UIKit

import SnapKit
import Then

protocol PageComponentProtocol where Self: UIViewController {
    var pageTitle: String { get }
}

final class Pager: BaseView {
    
    private var style = Style.default
    private var contents: [Content] = []
    private var currentIndex = 0 {
        didSet {
            contents.enumerated().forEach { index, content in
                content.button.isSelected = index == currentIndex
                content.button.titleLabel?.font = index == currentIndex ? style.titleActiveFont : style.titleDefaultFont
            }
        }
    }
    
    private let titleStackView = UIStackView()
    private let barBackgroundView = UIView()
    private let barView = UIView()
    
    private let containerView = UIView()
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    private var isSelected = false
    
    func setup(_ target: UIViewController, viewControllers: [PageComponentProtocol], style: Style = .default) {
        self.style = style
        setUI()
        
        target.addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: target)
        
        pageViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contents = viewControllers.map {
            let button = UIButton()
            button.titleLabel?.font = style.titleDefaultFont
            button.setTitleColor(style.titleDefaultColor, for: .normal)
            button.setTitleColor(style.titleActiveColor, for: .selected)
            button.setTitle($0.pageTitle, for: .normal)
            button.addTarget(self, action: #selector(selectButton), for: .touchUpInside)
            return Content(button: button, viewController: $0)
        }
    }
    
    @objc private func selectButton(_ sender: UIButton) {
        guard let index = contents.firstIndex(where: { $0.button === sender }),
              index != currentIndex else {
            return
        }

        isSelected = true
        pageViewController.view.isUserInteractionEnabled = false

        barView.snp.updateConstraints {
            $0.leading.equalToSuperview().inset(CGFloat(index) * barView.frame.width)
        }
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut) {
            self.barBackgroundView.layoutIfNeeded()
        } completion: { _ in
            self.isSelected = false
            self.pageViewController.view.isUserInteractionEnabled = true
        }

        let content = contents[index]
        pageViewController.setViewControllers(
            [content.viewController],
            direction: currentIndex < index ? .forward : .reverse,
            animated: true) { [weak self] _ in
            self?.currentIndex = index
        }
    }
    
    private func setUI() {
        addSubview(titleStackView)
        addSubview(barBackgroundView)
        barBackgroundView.addSubview(barView)
        addSubview(containerView)
        
        titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(style.buttonHeight)
        }
        
        barBackgroundView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(style.indicatorHeight)
        }
        
        barView.snp.makeConstraints {
            $0.directionalVerticalEdges.leading.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(barBackgroundView.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setPageViewController() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        if let viewController = contents.first?.viewController {
            pageViewController.setViewControllers([viewController], direction: .forward, animated: false)
            currentIndex = 0
        }
        
        for subview in pageViewController.view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.delegate = self
            }
        }
    }
    
    private func updatePagerButton() {
        let barCount = contents.count
        contents.forEach { content in
            titleStackView.addArrangedSubview(content.button)
        }
        barView.snp.makeConstraints {
            $0.width.equalToSuperview().dividedBy(max(barCount, 1))
        }
    }
}

extension Pager: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = contents.firstIndex(where: { $0.viewController == viewController }) else {
            return nil
        }
        
        let afterIndex = index + 1
        if afterIndex < contents.count {
            return contents[afterIndex].viewController
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = contents.firstIndex(where: { $0.viewController == viewController }) else {
            return nil
        }
        
        let beforeIndex = index - 1
        if beforeIndex >= 0 {
            return contents[beforeIndex].viewController
        }
        return nil
    }
}

extension Pager: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?.first,
              let index = contents.firstIndex(where: { $0.viewController == viewController }) else { return }
        
        currentIndex = index
    }
}

extension Pager: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isSelected else { return }
        let offsetX = scrollView.contentOffset.x
        let percentComplete = (offsetX - pageViewController.view.frame.width) / pageViewController.view.frame.width
        barView.snp.updateConstraints {
            $0.leading.equalToSuperview().inset((percentComplete + CGFloat(currentIndex)) * barView.frame.width)
        }
    }
}

extension Pager {
    
    struct Style {
        var titleDefaultColor: UIColor
        var titleActiveColor: UIColor
        var titleDefaultFont: UIFont
        var titleActiveFont: UIFont
        
        var buttonBackgroundColor: UIColor
        var buttonHeight: CGFloat
        
        var indicatorHeight: CGFloat
        var indicatorBarColor: UIColor
        
        static var `default` = Style(
            titleDefaultColor: .MGC.gray6,
            titleActiveColor: .MGC.green,
            titleDefaultFont: .notoSansR(14),
            titleActiveFont: .notoSansM(14),
            buttonBackgroundColor: .clear,
            buttonHeight: 43.0,
            indicatorHeight: 1.0,
            indicatorBarColor: .MGC.green
        )
    }
    
    struct Content {
        let button: UIButton
        let viewController: PageComponentProtocol
    }
}
