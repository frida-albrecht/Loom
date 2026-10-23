module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.719500e+02> : tensor<4x9x10xf32>}> : () -> tensor<4x9x10xf32>
    %1 = "tosa.const"() <{values = dense<-1.499000e+02> : tensor<4x9x1xf32>}> : () -> tensor<4x9x1xf32>
    %2 = tosa.minimum %0, %1 : (tensor<4x9x10xf32>, tensor<4x9x1xf32>) -> tensor<4x9x10xf32>
    %cast = tensor.cast %2 : tensor<4x9x10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

