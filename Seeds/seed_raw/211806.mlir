module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.519500e+02> : tensor<6xf32>}> : () -> tensor<6xf32>
    %1 = tosa.reciprocal %0 : (tensor<6xf32>) -> tensor<6xf32>
    %2 = tosa.maximum %1, %1 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xf32>
    %3 = tosa.maximum %2, %1 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xf32>
    %4 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %5 = tosa.tile %3, %4 : (tensor<6xf32>, !tosa.shape<1>) -> tensor<6xf32>
    %cast = tensor.cast %5 : tensor<6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

