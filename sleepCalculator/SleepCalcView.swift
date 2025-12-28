import SwiftUI

struct SleepCalcView: View {
  let mode: SleepCalcMode
  let calculate: (Double) -> [SleepResult]

  @State private var selectedTime = Date()
  @State private var results: [SleepResult] = []

  var body: some View {
    VStack(spacing: 24) {

      // 時間 picker
      HStack {
        Text(mode.prompt)

        DatePicker(
          "",
          selection: $selectedTime,
          displayedComponents: .hourAndMinute
        )
        .labelsHidden()
        .datePickerStyle(.compact) // 你也可以改 .wheel
        .frame(maxWidth: 120)

        Text(mode.unit)
      }
      .font(.title3)

      Text(mode.title)
        .font(.title2.bold())
        .padding(.top, 8)

      Button("開始計算") {
        let timeDouble = dateToDouble(selectedTime)
        results = calculate(timeDouble)
      }

      if !results.isEmpty {
        VStack(spacing: 12) {
          ForEach(results.indices, id: \.self) { index in
            ResultRow(
              cycle: results[index].cycle,
              time: results[index].time
            )

            if index != results.indices.last {
              Divider()
            }
          }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(24)
      }

      Spacer()
    }
    .padding()
    .onChange(of: mode) {
      results = []
    }
  }
}

func dateToDouble(_ date: Date) -> Double {
  let calendar = Calendar.current
  let hour = calendar.component(.hour, from: date)
  let minute = calendar.component(.minute, from: date)

  return Double(hour) + Double(minute) / 60.0
}

enum SleepCalcMode {
  case wakeTime   // 計算起床
  case bedTime    // 計算睡覺

  var title: String {
    switch self {
    case .wakeTime: return "我應該幾點起床？"
    case .bedTime:  return "我應該幾點睡覺？"
    }
  }

  var prompt: String {
    switch self {
    case .wakeTime: return "現在是"
    case .bedTime:  return "我明天要"
    }
  }

  var unit: String {
    switch self {
    case .wakeTime: return "點"
    case .bedTime:  return "點起床"
    }
  }
}
