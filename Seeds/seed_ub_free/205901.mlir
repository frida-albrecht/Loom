module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.566700e+02> : tensor<5x7xf32>}> : () -> tensor<5x7xf32>
    %1 = tosa.const_shape  {values = dense<[3, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.tile %0, %1 : (tensor<5x7xf32>, !tosa.shape<2>) -> tensor<15x7xf32>
    %3 = tosa.identity %2 : (tensor<15x7xf32>) -> tensor<15x7xf32>
    %4 = tosa.pow %3, %3 : (tensor<15x7xf32>, tensor<15x7xf32>) -> tensor<15x7xf32>
    %cast = tensor.cast %4 : tensor<15x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

