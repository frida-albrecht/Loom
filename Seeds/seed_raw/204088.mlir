module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<27> : tensor<7xi32>}> : () -> tensor<7xi32>
    %1 = tosa.const_shape  {values = dense<[7, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.reshape %0, %1 : (tensor<7xi32>, !tosa.shape<2>) -> tensor<7x1xi32>
    %3 = tosa.intdiv %2, %2 : (tensor<7x1xi32>, tensor<7x1xi32>) -> tensor<7x1xi32>
    %4 = tosa.logical_right_shift %3, %3 : (tensor<7x1xi32>, tensor<7x1xi32>) -> tensor<7x1xi32>
    %cast = tensor.cast %4 : tensor<7x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

