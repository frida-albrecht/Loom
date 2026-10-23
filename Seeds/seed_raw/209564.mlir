module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.924000e+01> : tensor<2x9xf32>}> : () -> tensor<2x9xf32>
    %1 = tosa.exp %0 : (tensor<2x9xf32>) -> tensor<2x9xf32>
    %2 = tosa.const_shape  {values = dense<[9, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.reshape %1, %2 : (tensor<2x9xf32>, !tosa.shape<2>) -> tensor<9x2xf32>
    %4 = tosa.ceil %3 : (tensor<9x2xf32>) -> tensor<9x2xf32>
    %cast = tensor.cast %4 : tensor<9x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

