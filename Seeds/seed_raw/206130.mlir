module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<95.1399993> : tensor<8xf32>}> : () -> tensor<8xf32>
    %1 = tosa.floor %0 : (tensor<8xf32>) -> tensor<8xf32>
    %2 = tosa.reduce_max %1 {axis = 0 : i32} : (tensor<8xf32>) -> tensor<1xf32>
    %3 = tosa.reciprocal %2 : (tensor<1xf32>) -> tensor<1xf32>
    %4 = tosa.ceil %3 : (tensor<1xf32>) -> tensor<1xf32>
    %5 = tosa.const_shape  {values = dense<1> : tensor<3xindex>} : () -> !tosa.shape<3>
    %6 = tosa.reshape %4, %5 : (tensor<1xf32>, !tosa.shape<3>) -> tensor<1x1x1xf32>
    %cast = tensor.cast %6 : tensor<1x1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

