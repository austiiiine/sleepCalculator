import SwiftUI

struct ContentView: View {
  @State private var currentMode: SleepCalcMode = .wakeTime

  var body: some View {
    VStack(spacing: 32) {

      // 標題
      VStack(alignment: .center, spacing: 8) {
        Text("睡眠週期計算器")
          .font(.largeTitle).bold()
        Text("計算睡眠週期，就算睡少少也不會累🏋️")
          .font(.body)
          .foregroundStyle(.gray)
      }
      .padding(.top, 20)

      // 切換模式
      HStack(spacing: 16) {

        // 計算起床時間
        Button {
          currentMode = .wakeTime
        } label: {
          HStack(spacing: 6) {
            Image(systemName: "sunrise.fill")
              .foregroundColor(currentMode == .wakeTime ? .orange : .gray)
            Text("計算起床時間")
          }
          .padding(.vertical, 10)
          .padding(.horizontal, 16)
          .background(Color(.systemGray6))
          .cornerRadius(99)
        }
        .foregroundColor(.black)

        // 計算睡覺時間
        Button {
          currentMode = .bedTime
        } label: {
          HStack(spacing: 6) {
            Image(systemName: "moon.stars.fill")
              .foregroundColor(currentMode == .bedTime ? .blue : .gray)
            Text("計算睡覺時間")
          }
          .padding(.vertical, 10)
          .padding(.horizontal, 16)
          .background(Color(.systemGray6))
          .cornerRadius(99)
        }
        .foregroundColor(.black)
      }

      // 共用 View：根據 mode 替換提示文字＋計算邏輯
      SleepCalcView(
        mode: currentMode,
        calculate: { value in
          currentMode == .wakeTime
          ? calculateWakeTimes(fromSleepTime: value)
          : calculateBedTimes(fromWakeTime: value)
        }
      )

      Spacer()
    }
    .padding(.horizontal)
  }

}

// 計算起床時間
func calculateWakeTimes(fromSleepTime time: Double) -> [SleepResult] {
  let sleepMinutes = time * 60
  let cycles = [3, 4, 5, 6]

  return cycles.map { c in
    let wake = sleepMinutes + 15 + Double(c * 90)
    return SleepResult(
      cycle: c,
      time: formatTime(wake)
    )
  }
}

// 計算睡覺時間
func calculateBedTimes(fromWakeTime time: Double) -> [SleepResult] {
  let wakeMinutes = time * 60
  let cycles = [6, 5, 4, 3]

  return cycles.map { c in
    let bed = wakeMinutes - Double(c * 90) - 15
    return SleepResult(
      cycle: c,
      time: formatTime(bed)
    )
  }
}

func formatTime(_ minutes: Double) -> String {
  let total = (Int(minutes) + 1440) % 1440
  let h = total / 60
  let m = total % 60
  return String(format: "%02d:%02d", h, m)
}

#Preview {
    ContentView()
}
