module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<104> : tensor<3x2x1x8xi64>}> : () -> tensor<3x2x1x8xi64>
    %1 = tosa.reduce_min %0 {axis = 1 : i32} : (tensor<3x2x1x8xi64>) -> tensor<3x1x1x8xi64>
    %2 = tosa.reduce_min %1 {axis = 1 : i32} : (tensor<3x1x1x8xi64>) -> tensor<3x1x1x8xi64>
    %cast = tensor.cast %2 : tensor<3x1x1x8xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

