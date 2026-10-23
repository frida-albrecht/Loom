module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.118300e+02> : tensor<6x7x10xf32>}> : () -> tensor<6x7x10xf32>
    %1 = tosa.log %0 : (tensor<6x7x10xf32>) -> tensor<6x7x10xf32>
    %2 = tosa.maximum %1, %1 : (tensor<6x7x10xf32>, tensor<6x7x10xf32>) -> tensor<6x7x10xf32>
    %3 = tosa.minimum %2, %1 : (tensor<6x7x10xf32>, tensor<6x7x10xf32>) -> tensor<6x7x10xf32>
    %cast = tensor.cast %3 : tensor<6x7x10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

