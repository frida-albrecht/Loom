module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<59> : tensor<7x3x3x7xi32>}> : () -> tensor<7x3x3x7xi32>
    %1 = tosa.const_shape  {values = dense<[147, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.reshape %0, %1 : (tensor<7x3x3x7xi32>, !tosa.shape<2>) -> tensor<147x3xi32>
    %cast = tensor.cast %2 : tensor<147x3xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

