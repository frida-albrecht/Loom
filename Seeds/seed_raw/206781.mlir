module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.015000e+01> : tensor<9x10xf32>}> : () -> tensor<9x10xf32>
    %1 = tosa.log %0 : (tensor<9x10xf32>) -> tensor<9x10xf32>
    %2 = tosa.ceil %1 : (tensor<9x10xf32>) -> tensor<9x10xf32>
    %cast = tensor.cast %2 : tensor<9x10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

