import SwiftUI

struct MultiTextField : UIViewRepresentable {
    
    func updateUIView(_ uiView: UITextView, context: Context) {
    }
    
    func makeCoordinator() -> MultiTextField.Coordinator {
        return MultiTextField.Coordinator(parent1: self)
    }
    
    @Binding var obj : CGFloat
    @Binding var textM: String
    @Binding var isEdit: Bool
    var hint: String
    
    func makeUIView(context: UIViewRepresentableContext<MultiTextField>) -> UITextView {
        let view = UITextView()
        view.font = .systemFont(ofSize: 15)
        if textM != "" {
            view.text = textM
        } else {
            view.text = hint
        }
        view.textColor = UIColor(isEdit ? Color.b50 : Color.b100) // Hint
        view.backgroundColor = UIColor(Color.white) // Background
        view.delegate = context.coordinator
        
        obj = view.contentSize.height
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        
        return view
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        var parent : MultiTextField
        init (parent1 : MultiTextField) {
            parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if self.parent.textM == "" {
                textView.text = ""
            }
            textView.textColor = .b100 // TextColor
            self.parent.obj = textView.contentSize.height
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.obj = textView.contentSize.height
            self.parent.textM = textView.text
        }
        
    }
}
