module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.185000e+01> : tensor<10x5x6xf32>}> : () -> tensor<10x5x6xf32>
    %1 = tosa.floor %0 : (tensor<10x5x6xf32>) -> tensor<10x5x6xf32>
    %2 = tosa.sigmoid %1 : (tensor<10x5x6xf32>) -> tensor<10x5x6xf32>
    %3 = tosa.const_shape  {values = dense<[1, 3, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %4 = tosa.tile %2, %3 : (tensor<10x5x6xf32>, !tosa.shape<3>) -> tensor<10x15x12xf32>
    %cast = tensor.cast %4 : tensor<10x15x12xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

