module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.471000e+01> : tensor<6xf32>}> : () -> tensor<6xf32>
    %1 = "tosa.const"() <{values = dense<1.412700e+02> : tensor<6xf32>}> : () -> tensor<6xf32>
    %2 = tosa.minimum %0, %1 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xf32>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<6xf32>) -> tensor<6xf32>
    %4 = tosa.reduce_sum %3 {axis = 0 : i32} : (tensor<6xf32>) -> tensor<1xf32>
    %5 = tosa.reciprocal %4 : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %5 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

