module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<51> : tensor<8x1x5x5xi32>}> : () -> tensor<8x1x5x5xi32>
    %1 = "tosa.const"() <{values = dense<-3> : tensor<1x1x5x1xi32>}> : () -> tensor<1x1x5x1xi32>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<8x1x5x5xi32>, tensor<1x1x5x1xi32>) -> tensor<8x1x5x5xi32>
    %3 = tosa.const_shape  {values = dense<1> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.tile %2, %3 : (tensor<8x1x5x5xi32>, !tosa.shape<4>) -> tensor<8x1x5x5xi32>
    %cast = tensor.cast %4 : tensor<8x1x5x5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

