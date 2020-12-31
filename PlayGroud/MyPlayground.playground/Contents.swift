import UIKit
import PlaygroundSupport

var str = "Hello, playground, hahahahahahahahhaahahahahha 모모모모모ㅗ모모모모모ㅗㅁ"

let view = UIView()
view.backgroundColor = .yellow
view.frame = CGRect(x: 0, y: 0, width: 400, height: 400)

let textView = UITextView()
textView.text = str
textView.font = UIFont.systemFont(ofSize: 20)
let maxSize = CGSize(width: 250, height: 1000)
let heightOnFont = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
let estimatedFrame = NSString(string: str).boundingRect(with: maxSize, options: heightOnFont, attributes: [.font: UIFont.systemFont(ofSize: 20)], context: nil)
textView.frame = CGRect(x: 0, y: 0, width: estimatedFrame.width + 20, height: estimatedFrame.height + 20)

view.addSubview(textView)

print(estimatedFrame.width)
print(estimatedFrame.height)

PlaygroundPage.current.liveView = view

