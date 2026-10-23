module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-42> : tensor<6x1xi64>}> : () -> tensor<6x1xi64>
    %1 = "tosa.const"() <{values = dense<-164> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<77> : tensor<i32>}> : () -> tensor<i32>
    %3 = tosa.clamp %0 {max_val = 92 : i64, min_val = 21 : i64} : (tensor<6x1xi64>) -> tensor<6x1xi64>
    %4 = tosa.intdiv %1, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %5 = tosa.minimum %3, %3 : (tensor<6x1xi64>, tensor<6x1xi64>) -> tensor<6x1xi64>
    %6 = "tosa.const"() <{values = dense<[1, 0]> : tensor<2xi32>}> : () -> tensor<2xi32>
    %7 = tosa.transpose %5 {perms = array<i32: 1, 0>} : (tensor<6x1xi64>) -> tensor<1x6xi64>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %7 : tensor<1x6xi64> to tensor<*xi64>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

