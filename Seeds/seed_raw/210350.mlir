module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.702300e+02> : tensor<7x2x2x4xf32>}> : () -> tensor<7x2x2x4xf32>
    %1 = tosa.const_shape  {values = dense<112> : tensor<1xindex>} : () -> !tosa.shape<1>
    %2 = tosa.reshape %0, %1 : (tensor<7x2x2x4xf32>, !tosa.shape<1>) -> tensor<112xf32>
    %cast = tensor.cast %2 : tensor<112xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

