module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.261000e+01> : tensor<5x6x1x3xf32>}> : () -> tensor<5x6x1x3xf32>
    %1 = tosa.const_shape  {values = dense<[2, 2, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.tile %0, %1 : (tensor<5x6x1x3xf32>, !tosa.shape<4>) -> tensor<10x12x1x3xf32>
    %3 = tosa.minimum %2, %2 : (tensor<10x12x1x3xf32>, tensor<10x12x1x3xf32>) -> tensor<10x12x1x3xf32>
    %cast = tensor.cast %3 : tensor<10x12x1x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

