module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<10x3x3xi1>}> : () -> tensor<10x3x3xi1>
    %1 = "tosa.const"() <{values = dense<true> : tensor<10x72x3xi1>}> : () -> tensor<10x72x3xi1>
    %2 = "tosa.const"() <{values = dense<1.941000e+01> : tensor<3x2x2x1xf32>}> : () -> tensor<3x2x2x1xf32>
    %3 = tosa.concat %0, %1 {axis = 1 : i32} : (tensor<10x3x3xi1>, tensor<10x72x3xi1>) -> tensor<10x75x3xi1>
    %4 = tosa.reduce_any %3 {axis = 1 : i32} : (tensor<10x75x3xi1>) -> tensor<10x1x3xi1>
    %5 = "tosa.const"() <{values = dense<false> : tensor<1xi1>}> : () -> tensor<1xi1>
    %6 = "tosa.const"() <{values = dense<false> : tensor<1xi1>}> : () -> tensor<1xi1>
    %7 = tosa.negate %4, %5, %6 : (tensor<10x1x3xi1>, tensor<1xi1>, tensor<1xi1>) -> tensor<10x1x3xi1>
    %8 = tosa.reduce_all %7 {axis = 2 : i32} : (tensor<10x1x3xi1>) -> tensor<10x1x1xi1>
    %9 = tosa.logical_and %8, %8 : (tensor<10x1x1xi1>, tensor<10x1x1xi1>) -> tensor<10x1x1xi1>
    %10 = tosa.argmax %9 {axis = 2 : i32} : (tensor<10x1x1xi1>) -> tensor<10x1xi32>
    %11 = tosa.sigmoid %2 : (tensor<3x2x2x1xf32>) -> tensor<3x2x2x1xf32>
    %12 = tosa.reciprocal %11 : (tensor<3x2x2x1xf32>) -> tensor<3x2x2x1xf32>
    %cast = tensor.cast %10 : tensor<10x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %12 : tensor<3x2x2x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

