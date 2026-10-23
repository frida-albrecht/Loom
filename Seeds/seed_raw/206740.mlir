module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.203900e+02> : tensor<2x1xf32>}> : () -> tensor<2x1xf32>
    %1 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.tile %0, %1 : (tensor<2x1xf32>, !tosa.shape<2>) -> tensor<2x1xf32>
    %3 = tosa.floor %2 : (tensor<2x1xf32>) -> tensor<2x1xf32>
    %cast = tensor.cast %3 : tensor<2x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

