module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<170> : tensor<1x9xi64>}> : () -> tensor<1x9xi64>
    %1 = tosa.reverse %0 {axis = 1 : i32} : (tensor<1x9xi64>) -> tensor<1x9xi64>
    %2 = tosa.sub %1, %1 : (tensor<1x9xi64>, tensor<1x9xi64>) -> tensor<1x9xi64>
    %cast = tensor.cast %2 : tensor<1x9xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

