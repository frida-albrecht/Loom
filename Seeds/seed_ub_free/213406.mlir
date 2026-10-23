module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-132> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = tosa.const_shape  {values = dense<1> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.reshape %0, %1 : (tensor<1xi32>, !tosa.shape<3>) -> tensor<1x1x1xi32>
    %3 = tosa.bitwise_xor %2, %2 : (tensor<1x1x1xi32>, tensor<1x1x1xi32>) -> tensor<1x1x1xi32>
    %4 = tosa.arithmetic_right_shift %3, %3 {round = false} : (tensor<1x1x1xi32>, tensor<1x1x1xi32>) -> tensor<1x1x1xi32>
    %cast = tensor.cast %4 : tensor<1x1x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

