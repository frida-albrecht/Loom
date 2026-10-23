module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<190> : tensor<5x3x2xi64>}> : () -> tensor<5x3x2xi64>
    %1 = tosa.reduce_min %0 {axis = 1 : i32} : (tensor<5x3x2xi64>) -> tensor<5x1x2xi64>
    %2 = tosa.abs %1 : (tensor<5x1x2xi64>) -> tensor<5x1x2xi64>
    %cast = tensor.cast %2 : tensor<5x1x2xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

