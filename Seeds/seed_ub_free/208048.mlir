module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.634500e+02> : tensor<2x7xf32>}> : () -> tensor<2x7xf32>
    %1 = "tosa.const"() <{values = dense<-7.000000e-02> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %2 = tosa.pow %0, %1 : (tensor<2x7xf32>, tensor<1x1xf32>) -> tensor<2x7xf32>
    %cast = tensor.cast %2 : tensor<2x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

