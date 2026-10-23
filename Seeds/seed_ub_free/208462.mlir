module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-138> : tensor<9x8x3xi32>}> : () -> tensor<9x8x3xi32>
    %1 = tosa.const_shape  {values = dense<[3, 3, 24, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.reshape %0, %1 : (tensor<9x8x3xi32>, !tosa.shape<4>) -> tensor<3x3x24x1xi32>
    %cast = tensor.cast %2 : tensor<3x3x24x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

