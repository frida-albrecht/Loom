module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<10> : tensor<6xi64>}> : () -> tensor<6xi64>
    %1 = "tosa.const"() <{values = dense<83> : tensor<6xi64>}> : () -> tensor<6xi64>
    %2 = tosa.arithmetic_right_shift %0, %1 {round = false} : (tensor<6xi64>, tensor<6xi64>) -> tensor<6xi64>
    %3 = tosa.minimum %2, %2 : (tensor<6xi64>, tensor<6xi64>) -> tensor<6xi64>
    %4 = tosa.bitwise_or %3, %2 : (tensor<6xi64>, tensor<6xi64>) -> tensor<6xi64>
    %5 = tosa.identity %4 : (tensor<6xi64>) -> tensor<6xi64>
    %6 = tosa.sub %5, %5 : (tensor<6xi64>, tensor<6xi64>) -> tensor<6xi64>
    %7 = tosa.reverse %6 {axis = 0 : i32} : (tensor<6xi64>) -> tensor<6xi64>
    %cast = tensor.cast %7 : tensor<6xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

