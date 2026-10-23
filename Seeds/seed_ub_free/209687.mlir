module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<143> : tensor<3x10xi32>}> : () -> tensor<3x10xi32>
    %1 = tosa.const_shape  {values = dense<3> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.tile %0, %1 : (tensor<3x10xi32>, !tosa.shape<2>) -> tensor<9x30xi32>
    %cast = tensor.cast %2 : tensor<9x30xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

