module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.765000e+01> : tensor<5x10x2x6xf32>}> : () -> tensor<5x10x2x6xf32>
    %1 = tosa.const_shape  {values = dense<[2, 3, 3, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.tile %0, %1 : (tensor<5x10x2x6xf32>, !tosa.shape<4>) -> tensor<10x30x6x6xf32>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<10x30x6x6xf32>) -> tensor<10x30x6x6xf32>
    %cast = tensor.cast %3 : tensor<10x30x6x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

