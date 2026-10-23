module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<167> : tensor<5x9xi64>}> : () -> tensor<5x9xi64>
    %1 = tosa.reduce_sum %0 {axis = 1 : i32} : (tensor<5x9xi64>) -> tensor<5x1xi64>
    %2 = tosa.bitwise_and %1, %1 : (tensor<5x1xi64>, tensor<5x1xi64>) -> tensor<5x1xi64>
    %cast = tensor.cast %2 : tensor<5x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

