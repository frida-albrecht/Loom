module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.612100e+02> : tensor<6x6x7x7xf32>}> : () -> tensor<6x6x7x7xf32>
    %1 = "tosa.const"() <{values = dense<-2.780000e+00> : tensor<1x1x1x7xf32>}> : () -> tensor<1x1x1x7xf32>
    %2 = tosa.maximum %0, %1 : (tensor<6x6x7x7xf32>, tensor<1x1x1x7xf32>) -> tensor<6x6x7x7xf32>
    %cast = tensor.cast %2 : tensor<6x6x7x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

