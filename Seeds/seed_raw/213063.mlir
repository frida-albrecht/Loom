module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<31> : tensor<7x2xi32>}> : () -> tensor<7x2xi32>
    %1 = tosa.const_shape  {values = dense<[1, 1, 1, 14]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.reshape %0, %1 : (tensor<7x2xi32>, !tosa.shape<4>) -> tensor<1x1x1x14xi32>
    %3 = tosa.bitwise_xor %2, %2 : (tensor<1x1x1x14xi32>, tensor<1x1x1x14xi32>) -> tensor<1x1x1x14xi32>
    %cast = tensor.cast %3 : tensor<1x1x1x14xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

