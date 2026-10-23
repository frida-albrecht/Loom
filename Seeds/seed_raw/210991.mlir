module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.125000e+02> : tensor<6x1x10x5xf32>}> : () -> tensor<6x1x10x5xf32>
    %1 = tosa.const_shape  {values = dense<[12, 1, 5, 5]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.reshape %0, %1 : (tensor<6x1x10x5xf32>, !tosa.shape<4>) -> tensor<12x1x5x5xf32>
    %3 = tosa.reciprocal %2 : (tensor<12x1x5x5xf32>) -> tensor<12x1x5x5xf32>
    %4 = tosa.abs %3 : (tensor<12x1x5x5xf32>) -> tensor<12x1x5x5xf32>
    %cast = tensor.cast %4 : tensor<12x1x5x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

