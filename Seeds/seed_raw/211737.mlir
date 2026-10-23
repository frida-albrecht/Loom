module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<198> : tensor<5x2x2x10xi64>}> : () -> tensor<5x2x2x10xi64>
    %1 = tosa.reduce_sum %0 {axis = 1 : i32} : (tensor<5x2x2x10xi64>) -> tensor<5x1x2x10xi64>
    %cast = tensor.cast %1 : tensor<5x1x2x10xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

