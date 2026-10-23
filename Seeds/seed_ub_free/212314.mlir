module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.836100e+02> : tensor<2xf32>}> : () -> tensor<2xf32>
    %1 = tosa.tanh %0 : (tensor<2xf32>) -> tensor<2xf32>
    %2 = tosa.reduce_min %1 {axis = 0 : i32} : (tensor<2xf32>) -> tensor<1xf32>
    %3 = tosa.reduce_sum %2 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %3 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

