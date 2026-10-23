module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-51> : tensor<3x9x7x8xi32>}> : () -> tensor<3x9x7x8xi32>
    %1 = tosa.bitwise_not %0 : (tensor<3x9x7x8xi32>) -> tensor<3x9x7x8xi32>
    %2 = tosa.bitwise_not %1 : (tensor<3x9x7x8xi32>) -> tensor<3x9x7x8xi32>
    %3 = tosa.const_shape  {values = dense<[1, 3, 2, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.tile %2, %3 : (tensor<3x9x7x8xi32>, !tosa.shape<4>) -> tensor<3x27x14x8xi32>
    %cast = tensor.cast %4 : tensor<3x27x14x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

