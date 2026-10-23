module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3.960000e+00> : tensor<6xf32>}> : () -> tensor<6xf32>
    %1 = "tosa.const"() <{values = dense<-1.354700e+02> : tensor<6xf32>}> : () -> tensor<6xf32>
    %2 = tosa.minimum %0, %1 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xf32>
    %3 = tosa.abs %2 : (tensor<6xf32>) -> tensor<6xf32>
    %4 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %5 = tosa.tile %3, %4 : (tensor<6xf32>, !tosa.shape<1>) -> tensor<6xf32>
    %6 = tosa.tanh %5 : (tensor<6xf32>) -> tensor<6xf32>
    %7 = tosa.exp %6 : (tensor<6xf32>) -> tensor<6xf32>
    %8 = tosa.reciprocal %7 : (tensor<6xf32>) -> tensor<6xf32>
    %cast = tensor.cast %8 : tensor<6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

