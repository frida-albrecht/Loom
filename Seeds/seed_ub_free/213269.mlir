module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.967900e+02> : tensor<5x3xf32>}> : () -> tensor<5x3xf32>
    %1 = tosa.sigmoid %0 : (tensor<5x3xf32>) -> tensor<5x3xf32>
    %2 = tosa.const_shape  {values = dense<[1, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.tile %1, %2 : (tensor<5x3xf32>, !tosa.shape<2>) -> tensor<5x6xf32>
    %4 = tosa.maximum %3, %3 : (tensor<5x6xf32>, tensor<5x6xf32>) -> tensor<5x6xf32>
    %5 = tosa.identity %4 : (tensor<5x6xf32>) -> tensor<5x6xf32>
    %cast = tensor.cast %5 : tensor<5x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

