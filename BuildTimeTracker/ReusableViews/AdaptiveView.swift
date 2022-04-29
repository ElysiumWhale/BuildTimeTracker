import SwiftUI

struct AdaptiveView<InputView: View>: View {
    var inputView: InputView

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                inputView
                Spacer()
            }
            Spacer()
        }
    }

    init(@ViewBuilder _ viewBuilder: () -> InputView) {
        self.inputView = viewBuilder()
    }
}

struct AdaptiveView_Previews: PreviewProvider {
    static var previews: some View {
        AdaptiveView {
            Text("No logs").fontWeight(.heavy)
        }
    }
}
