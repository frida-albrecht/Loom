module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.393300e+02> : tensor<5x1xf32>}> : () -> tensor<5x1xf32>
    %1 = "tosa.const"() <{values = dense<-8.474000e+01> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %2 = tosa.pow %0, %1 : (tensor<5x1xf32>, tensor<1x1xf32>) -> tensor<5x1xf32>
    %3 = tosa.log %2 : (tensor<5x1xf32>) -> tensor<5x1xf32>
    %4 = tosa.reduce_sum %3 {axis = 0 : i32} : (tensor<5x1xf32>) -> tensor<1x1xf32>
    %cast = tensor.cast %4 : tensor<1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

