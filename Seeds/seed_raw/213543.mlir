module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<196> : tensor<3x4xi64>}> : () -> tensor<3x4xi64>
    %1 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<3x4xi64>) -> tensor<1x4xi64>
    %2 = tosa.add %1, %1 : (tensor<1x4xi64>, tensor<1x4xi64>) -> tensor<1x4xi64>
    %3 = tosa.arithmetic_right_shift %2, %2 {round = false} : (tensor<1x4xi64>, tensor<1x4xi64>) -> tensor<1x4xi64>
    %4 = tosa.logical_right_shift %3, %1 : (tensor<1x4xi64>, tensor<1x4xi64>) -> tensor<1x4xi64>
    %cast = tensor.cast %4 : tensor<1x4xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

