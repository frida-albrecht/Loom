module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.616000e+01> : tensor<2x7xf32>}> : () -> tensor<2x7xf32>
    %1 = tosa.tanh %0 : (tensor<2x7xf32>) -> tensor<2x7xf32>
    %2 = tosa.concat %1, %1 {axis = 1 : i32} : (tensor<2x7xf32>, tensor<2x7xf32>) -> tensor<2x14xf32>
    %cast = tensor.cast %2 : tensor<2x14xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

