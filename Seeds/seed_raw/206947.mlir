module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.036800e+02> : tensor<9x1x6xf32>}> : () -> tensor<9x1x6xf32>
    %1 = "tosa.const"() <{values = dense<109> : tensor<9xi32>}> : () -> tensor<9xi32>
    %2 = tosa.log %0 : (tensor<9x1x6xf32>) -> tensor<9x1x6xf32>
    %3 = tosa.clz %1 : (tensor<9xi32>) -> tensor<9xi32>
    %cast = tensor.cast %2 : tensor<9x1x6xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %3 : tensor<9xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

