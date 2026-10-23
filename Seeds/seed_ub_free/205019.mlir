module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8> : tensor<2x4x9xi32>}> : () -> tensor<2x4x9xi32>
    %1 = "tosa.const"() <{values = dense<-23> : tensor<2x9x6xi32>}> : () -> tensor<2x9x6xi32>
    %2 = "tosa.const"() <{values = dense<6.681000e+01> : tensor<7x5x10xf32>}> : () -> tensor<7x5x10xf32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<2x4x9xi32>, tensor<2x9x6xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<2x4x6xi32>
    %6 = tosa.tanh %2 : (tensor<7x5x10xf32>) -> tensor<7x5x10xf32>
    %7 = tosa.minimum %5, %5 : (tensor<2x4x6xi32>, tensor<2x4x6xi32>) -> tensor<2x4x6xi32>
    %cast = tensor.cast %6 : tensor<7x5x10xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<2x4x6xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

