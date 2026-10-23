module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<132> : tensor<3x9x3xi32>}> : () -> tensor<3x9x3xi32>
    %1 = "tosa.const"() <{values = dense<40> : tensor<1x1x3xi32>}> : () -> tensor<1x1x3xi32>
    %2 = "tosa.const"() <{values = dense<7.504000e+01> : tensor<5x9x2xf32>}> : () -> tensor<5x9x2xf32>
    %3 = tosa.intdiv %0, %1 : (tensor<3x9x3xi32>, tensor<1x1x3xi32>) -> tensor<3x9x3xi32>
    %4 = tosa.reverse %3 {axis = 1 : i32} : (tensor<3x9x3xi32>) -> tensor<3x9x3xi32>
    %5 = tosa.floor %2 : (tensor<5x9x2xf32>) -> tensor<5x9x2xf32>
    %6 = tosa.log %5 : (tensor<5x9x2xf32>) -> tensor<5x9x2xf32>
    %cast = tensor.cast %4 : tensor<3x9x3xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<5x9x2xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

