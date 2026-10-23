module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8.705000e+01> : tensor<2x3x6xf32>}> : () -> tensor<2x3x6xf32>
    %1 = tosa.const_shape  {values = dense<1> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.tile %0, %1 : (tensor<2x3x6xf32>, !tosa.shape<3>) -> tensor<2x3x6xf32>
    %cast = tensor.cast %2 : tensor<2x3x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

