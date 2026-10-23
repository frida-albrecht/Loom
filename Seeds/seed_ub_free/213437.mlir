module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<130> : tensor<2x3x9xi32>}> : () -> tensor<2x3x9xi32>
    %1 = "tosa.const"() <{values = dense<-62> : tensor<1x3x1xi32>}> : () -> tensor<1x3x1xi32>
    %2 = "tosa.const"() <{values = dense<-1.343400e+02> : tensor<8x4x3xf32>}> : () -> tensor<8x4x3xf32>
    %3 = tosa.bitwise_and %0, %1 : (tensor<2x3x9xi32>, tensor<1x3x1xi32>) -> tensor<2x3x9xi32>
    %4 = tosa.bitwise_and %3, %3 : (tensor<2x3x9xi32>, tensor<2x3x9xi32>) -> tensor<2x3x9xi32>
    %5 = tosa.minimum %4, %4 : (tensor<2x3x9xi32>, tensor<2x3x9xi32>) -> tensor<2x3x9xi32>
    %6 = tosa.add %5, %4 : (tensor<2x3x9xi32>, tensor<2x3x9xi32>) -> tensor<2x3x9xi32>
    %7 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %8 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %9 = tosa.negate %6, %7, %8 : (tensor<2x3x9xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<2x3x9xi32>
    %10 = tosa.floor %2 : (tensor<8x4x3xf32>) -> tensor<8x4x3xf32>
    %11 = tosa.floor %10 : (tensor<8x4x3xf32>) -> tensor<8x4x3xf32>
    %cast = tensor.cast %9 : tensor<2x3x9xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %11 : tensor<8x4x3xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

