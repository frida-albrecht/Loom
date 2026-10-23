module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.450000e+00> : tensor<5x7xf32>}> : () -> tensor<5x7xf32>
    %1 = tosa.sigmoid %0 : (tensor<5x7xf32>) -> tensor<5x7xf32>
    %2 = tosa.identity %1 : (tensor<5x7xf32>) -> tensor<5x7xf32>
    %3 = tosa.floor %2 : (tensor<5x7xf32>) -> tensor<5x7xf32>
    %4 = tosa.reduce_min %3 {axis = 1 : i32} : (tensor<5x7xf32>) -> tensor<5x1xf32>
    %cast = tensor.cast %4 : tensor<5x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

