module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<193> : tensor<2x7xi32>}> : () -> tensor<2x7xi32>
    %1 = tosa.const_shape  {values = dense<[7, 1, 1, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.reshape %0, %1 : (tensor<2x7xi32>, !tosa.shape<4>) -> tensor<7x1x1x2xi32>
    %cast = tensor.cast %2 : tensor<7x1x1x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

