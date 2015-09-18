# SpringMenu
Collapsable Spring Menu

A simple collapsable menu using Spring Animation inspired by https://dribbble.com/shots/2232906-Spring-Menu-Made-with-Principle.


![Spring Menu](https://raw.githubusercontent.com/sauvikatinnofied/SpringMenu/master/ezgif.com-crop.gif)


### Usages


```swift
        var newButton = SpringMenuButton(frame: CGRectMake(20.0, 250.0, 88.0, 88.0))
        self.view.addSubview(newButton)
        newButton.numberOfButtons = 3
        newButton.delegateVC = self
```
Trace Button Click Event By implememting `SpringMenuButtonDelegate` in yor view controller

```swift
extension ViewController: SpringMenuButtonDelegate{
    func didTapOnButton(sender: UIButton, atIndex: Int) {
        println("Button tapped -> \(atIndex)")
    }
}
```
