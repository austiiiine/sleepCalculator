import SwiftUI

struct ResultRow: View {
  let cycle: Int
  let time: String

  var body: some View {
    HStack {

      HStack(alignment: .bottom, spacing: 4) {
        Text("\(cycle)")
          .font(.body)
        Text("個週期")
          .font(.caption)
      }


      Spacer()

      HStack(alignment: .center, spacing: 24) {
        Text(time)
          .font(.title3.bold())
        Button {
          // 之後再接鬧鐘功能
        } label: {
          Label("設鬧鐘", systemImage: "alarm")
        }
        .buttonStyle(.bordered)
      }
    }
    .padding(.horizontal, 4)
    .padding(.vertical, 6)
    .background(Color(.systemGray6))

  }
}

#Preview {
  ResultRow(cycle: 3, time: "16:45")
}
