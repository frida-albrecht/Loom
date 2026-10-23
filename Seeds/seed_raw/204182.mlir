module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.022200e+02> : tensor<7x1x2x9xf32>}> : () -> tensor<7x1x2x9xf32>
    %1 = tosa.reduce_max %0 {axis = 3 : i32} : (tensor<7x1x2x9xf32>) -> tensor<7x1x2x1xf32>
    %2 = tosa.reciprocal %1 : (tensor<7x1x2x1xf32>) -> tensor<7x1x2x1xf32>
    %3 = tosa.sigmoid %2 : (tensor<7x1x2x1xf32>) -> tensor<7x1x2x1xf32>
    %4 = tosa.floor %3 : (tensor<7x1x2x1xf32>) -> tensor<7x1x2x1xf32>
    %cast = tensor.cast %4 : tensor<7x1x2x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

