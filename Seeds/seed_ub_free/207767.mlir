module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<6x6x9xi1>}> : () -> tensor<6x6x9xi1>
    %1 = "tosa.const"() <{values = dense<1.508400e+02> : tensor<9x8x3x3xf32>}> : () -> tensor<9x8x3x3xf32>
    %2 = tosa.reduce_min %0 {axis = 1 : i32} : (tensor<6x6x9xi1>) -> tensor<6x1x9xi1>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<6x1x9xi1>) -> tensor<1x9xi32>
    %4 = tosa.reciprocal %1 : (tensor<9x8x3x3xf32>) -> tensor<9x8x3x3xf32>
    %5 = tosa.tanh %4 : (tensor<9x8x3x3xf32>) -> tensor<9x8x3x3xf32>
    %6 = tosa.argmax %5 {axis = 1 : i32} : (tensor<9x8x3x3xf32>) -> tensor<9x3x3xi32>
    %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %8 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %9 = tosa.negate %4, %7, %8 : (tensor<9x8x3x3xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<9x8x3x3xf32>
    %cast = tensor.cast %3 : tensor<1x9xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<9x3x3xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %9 : tensor<9x8x3x3xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

