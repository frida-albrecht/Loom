module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.261600e+02> : tensor<8x9x10x1xf32>}> : () -> tensor<8x9x10x1xf32>
    %1 = tosa.floor %0 : (tensor<8x9x10x1xf32>) -> tensor<8x9x10x1xf32>
    %2 = tosa.const_shape  {values = dense<[2, 3, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = tosa.tile %1, %2 : (tensor<8x9x10x1xf32>, !tosa.shape<4>) -> tensor<16x27x10x1xf32>
    %cast = tensor.cast %3 : tensor<16x27x10x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

