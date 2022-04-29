import SwiftUI

struct LogListCellView: View {
    let log: BuildLog

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Scheme: \(log.scheme)")
                    .font(.title2)
                Text("Type: \(log.title)")
                    .font(.title2)
                Text(log.startDate.formatted())
                    .font(.callout)
            }
            Spacer()
            Text(log.duration.asHMS())
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(5)
        }
        .padding(10)
        .background(.blue)
        .cornerRadius(5)
        .foregroundColor(.white)
    }
}

struct LogListCellView_Previews: PreviewProvider {
    static var previews: some View {
        LogListCellView(log: .mock)
    }
}

private extension BuildLog {
    static var mock: Self {
        BuildLog(scheme: .mock,
                 timestampStart: 0,
                 timestampEnd: 0,
                 duration: 10,
                 fileName: .mock,
                 title: .mock,
                 uniqueIdentifier: .mock,
                 type: .mock)
    }
}
