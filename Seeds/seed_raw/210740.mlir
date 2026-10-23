module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.920000e+01> : tensor<10x8xf32>}> : () -> tensor<10x8xf32>
    %1 = tosa.tanh %0 : (tensor<10x8xf32>) -> tensor<10x8xf32>
    %2 = tosa.exp %1 : (tensor<10x8xf32>) -> tensor<10x8xf32>
    %3 = tosa.const_shape  {values = dense<[2, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.tile %2, %3 : (tensor<10x8xf32>, !tosa.shape<2>) -> tensor<20x8xf32>
    %5 = tosa.maximum %4, %4 : (tensor<20x8xf32>, tensor<20x8xf32>) -> tensor<20x8xf32>
    %6 = tosa.rsqrt %5 : (tensor<20x8xf32>) -> tensor<20x8xf32>
    %7 = tosa.identity %6 : (tensor<20x8xf32>) -> tensor<20x8xf32>
    %cast = tensor.cast %7 : tensor<20x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

