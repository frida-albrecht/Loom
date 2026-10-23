module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2.000000e+00> : tensor<7xf32>}> : () -> tensor<7xf32>
    %1 = "tosa.const"() <{values = dense<9.177000e+01> : tensor<7xf32>}> : () -> tensor<7xf32>
    %2 = tosa.sub %0, %1 : (tensor<7xf32>, tensor<7xf32>) -> tensor<7xf32>
    %3 = tosa.reduce_max %2 {axis = 0 : i32} : (tensor<7xf32>) -> tensor<1xf32>
    %4 = tosa.minimum %3, %3 : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %4 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

