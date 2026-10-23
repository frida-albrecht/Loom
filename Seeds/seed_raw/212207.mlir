module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.752000e+01> : tensor<7x9x1x7xf32>}> : () -> tensor<7x9x1x7xf32>
    %1 = "tosa.const"() <{values = dense<17> : tensor<2x1x3x2xi32>}> : () -> tensor<2x1x3x2xi32>
    %2 = "tosa.const"() <{values = dense<-176> : tensor<1x1x1x2xi32>}> : () -> tensor<1x1x1x2xi32>
    %3 = tosa.tanh %0 : (tensor<7x9x1x7xf32>) -> tensor<7x9x1x7xf32>
    %4 = tosa.exp %3 : (tensor<7x9x1x7xf32>) -> tensor<7x9x1x7xf32>
    %5 = tosa.tanh %4 : (tensor<7x9x1x7xf32>) -> tensor<7x9x1x7xf32>
    %6 = tosa.logical_right_shift %1, %2 : (tensor<2x1x3x2xi32>, tensor<1x1x1x2xi32>) -> tensor<2x1x3x2xi32>
    %7 = tosa.logical_left_shift %6, %6 : (tensor<2x1x3x2xi32>, tensor<2x1x3x2xi32>) -> tensor<2x1x3x2xi32>
    %8 = tosa.pow %4, %3 : (tensor<7x9x1x7xf32>, tensor<7x9x1x7xf32>) -> tensor<7x9x1x7xf32>
    %9 = tosa.intdiv %6, %7 : (tensor<2x1x3x2xi32>, tensor<2x1x3x2xi32>) -> tensor<2x1x3x2xi32>
    %10 = tosa.bitwise_or %7, %9 : (tensor<2x1x3x2xi32>, tensor<2x1x3x2xi32>) -> tensor<2x1x3x2xi32>
    %11 = tosa.logical_right_shift %9, %10 : (tensor<2x1x3x2xi32>, tensor<2x1x3x2xi32>) -> tensor<2x1x3x2xi32>
    %cast = tensor.cast %5 : tensor<7x9x1x7xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<7x9x1x7xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %11 : tensor<2x1x3x2xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

