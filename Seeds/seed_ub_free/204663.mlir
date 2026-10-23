module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<106> : tensor<9x9x9xi32>}> : () -> tensor<9x9x9xi32>
    %1 = "tosa.const"() <{values = dense<46> : tensor<9x9x1xi32>}> : () -> tensor<9x9x1xi32>
    %2 = "tosa.const"() <{values = dense<-8.182000e+01> : tensor<4x4x9x3xf32>}> : () -> tensor<4x4x9x3xf32>
    %3 = "tosa.const"() <{values = dense<8.806000e+01> : tensor<4x1x1x3xf32>}> : () -> tensor<4x1x1x3xf32>
    %4 = tosa.intdiv %0, %1 : (tensor<9x9x9xi32>, tensor<9x9x1xi32>) -> tensor<9x9x9xi32>
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<4x4x9x3xf32>}> : () -> tensor<4x4x9x3xf32>
    %cl0 = tosa.maximum %2, %c0 : (tensor<4x4x9x3xf32>, tensor<4x4x9x3xf32>) -> tensor<4x4x9x3xf32>
    %5 = tosa.pow %cl0, %3 : (tensor<4x4x9x3xf32>, tensor<4x1x1x3xf32>) -> tensor<4x4x9x3xf32>
    %6 = tosa.intdiv %4, %4 : (tensor<9x9x9xi32>, tensor<9x9x9xi32>) -> tensor<9x9x9xi32>
    %7 = tosa.intdiv %6, %4 : (tensor<9x9x9xi32>, tensor<9x9x9xi32>) -> tensor<9x9x9xi32>
    %cast = tensor.cast %5 : tensor<4x4x9x3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<9x9x9xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}