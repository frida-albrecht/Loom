module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9.775000e+01> : tensor<3x6x1xf32>}> : () -> tensor<3x6x1xf32>
    %1 = tosa.ceil %0 : (tensor<3x6x1xf32>) -> tensor<3x6x1xf32>
    %2 = tosa.reduce_max %1 {axis = 1 : i32} : (tensor<3x6x1xf32>) -> tensor<3x1x1xf32>
    %3 = tosa.reduce_product %2 {axis = 2 : i32} : (tensor<3x1x1xf32>) -> tensor<3x1x1xf32>
    %4 = tosa.reduce_min %3 {axis = 2 : i32} : (tensor<3x1x1xf32>) -> tensor<3x1x1xf32>
    %cast = tensor.cast %4 : tensor<3x1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

