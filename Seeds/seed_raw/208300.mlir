module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.446700e+02> : tensor<2x2xf32>}> : () -> tensor<2x2xf32>
    %1 = tosa.floor %0 : (tensor<2x2xf32>) -> tensor<2x2xf32>
    %2 = tosa.log %1 : (tensor<2x2xf32>) -> tensor<2x2xf32>
    %3 = tosa.pow %2, %2 : (tensor<2x2xf32>, tensor<2x2xf32>) -> tensor<2x2xf32>
    %cast = tensor.cast %3 : tensor<2x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

