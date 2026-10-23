module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6.509000e+01> : tensor<1x7x10x1xf32>}> : () -> tensor<1x7x10x1xf32>
    %1 = tosa.const_shape  {values = dense<[2, 2, 3, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.tile %0, %1 : (tensor<1x7x10x1xf32>, !tosa.shape<4>) -> tensor<2x14x30x3xf32>
    %cast = tensor.cast %2 : tensor<2x14x30x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

