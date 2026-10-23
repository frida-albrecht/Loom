module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<92> : tensor<2x6xi32>}> : () -> tensor<2x6xi32>
    %1 = tosa.const_shape  {values = dense<2> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.tile %0, %1 : (tensor<2x6xi32>, !tosa.shape<2>) -> tensor<4x12xi32>
    %cast = tensor.cast %2 : tensor<4x12xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

