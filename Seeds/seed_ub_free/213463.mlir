module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<76> : tensor<1x7xi32>}> : () -> tensor<1x7xi32>
    %1 = "tosa.const"() <{values = dense<154> : tensor<1x7xi32>}> : () -> tensor<1x7xi32>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<1x7xi32>, tensor<1x7xi32>) -> tensor<1x7xi32>
    %3 = tosa.reduce_max %2 {axis = 1 : i32} : (tensor<1x7xi32>) -> tensor<1x1xi32>
    %4 = tosa.const_shape  {values = dense<1> : tensor<4xindex>} : () -> !tosa.shape<4>
    %5 = tosa.reshape %3, %4 : (tensor<1x1xi32>, !tosa.shape<4>) -> tensor<1x1x1x1xi32>
    %cast = tensor.cast %5 : tensor<1x1x1x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

