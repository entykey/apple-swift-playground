//* version 1
import Foundation

let mainTime: DispatchTime = DispatchTime.now()

print("this program measure time taken for its to execute.")

// End of main
let duration: UInt64 = DispatchTime.now().uptimeNanoseconds - mainTime.uptimeNanoseconds
let elapsedMicro: Double = Double(duration) / 1_000
let elapsedMs: Double = Double(duration) / 1_000_000
let elapsedSec: Double = Double(duration) / 1_000_000_000

print("\n⌛️ Execution time: \(duration) ns (\(elapsedMs) ms) (\(elapsedMicro) µs) (\(elapsedSec) s)")
//*/


/* 
Output 1:
this program measure time taken for its to execute.

⌛️ Execution time: 179983 ns (0.179983 ms) (179.983 µs) (0.000179983 s)

Output 2:
this program measure time taken for its to execute.

⌛️ Execution time: 1025065 ns (1.025065 ms) (1025.065 µs) (0.001025065 s)

Output 3:
this program measure time taken for its to execute.

⌛️ Execution time: 460952 ns (0.460952 ms) (460.952 µs) (0.000460952 s)

Output 4:
this program measure time taken for its to execute.

⌛️ Execution time: 194637 ns (0.194637 ms) (194.637 µs) (0.000194637 s)

Output 5:
this program measure time taken for its to execute.

⌛️ Execution time: 517006 ns (0.517006 ms) (517.006 µs) (0.000517006 s)

Output 6: (without printing any lines)

⌛️ Execution time: 91 ns (9.1e-05 ms) (0.091 µs) (9.1e-08 s)
*/
