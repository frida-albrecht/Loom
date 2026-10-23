module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.172400e+02> : tensor<1x7xf32>}> : () -> tensor<1x7xf32>
    %1 = tosa.floor %0 : (tensor<1x7xf32>) -> tensor<1x7xf32>
    %cast = tensor.cast %1 : tensor<1x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

