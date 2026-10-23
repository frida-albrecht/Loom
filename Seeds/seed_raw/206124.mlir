module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.100000e+01> : tensor<9x6x3xf32>}> : () -> tensor<9x6x3xf32>
    %1 = "tosa.const"() <{values = dense<1.996300e+02> : tensor<1x6x3xf32>}> : () -> tensor<1x6x3xf32>
    %2 = "tosa.const"() <{values = dense<-162> : tensor<7x9x6x9xi64>}> : () -> tensor<7x9x6x9xi64>
    %3 = "tosa.const"() <{values = dense<145> : tensor<1x1x6x1xi64>}> : () -> tensor<1x1x6x1xi64>
    %4 = tosa.sub %0, %1 : (tensor<9x6x3xf32>, tensor<1x6x3xf32>) -> tensor<9x6x3xf32>
    %5 = tosa.identity %4 : (tensor<9x6x3xf32>) -> tensor<9x6x3xf32>
    %6 = tosa.sigmoid %5 : (tensor<9x6x3xf32>) -> tensor<9x6x3xf32>
    %7 = tosa.bitwise_or %2, %3 : (tensor<7x9x6x9xi64>, tensor<1x1x6x1xi64>) -> tensor<7x9x6x9xi64>
    %8 = tosa.identity %6 : (tensor<9x6x3xf32>) -> tensor<9x6x3xf32>
    %9 = tosa.logical_right_shift %7, %7 : (tensor<7x9x6x9xi64>, tensor<7x9x6x9xi64>) -> tensor<7x9x6x9xi64>
    %10 = tosa.reverse %7 {axis = 0 : i32} : (tensor<7x9x6x9xi64>) -> tensor<7x9x6x9xi64>
    %cast = tensor.cast %8 : tensor<9x6x3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<7x9x6x9xi64> to tensor<*xi64>
    %cast_1 = tensor.cast %10 : tensor<7x9x6x9xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    call @printMemrefI64(%cast_1) : (tensor<*xi64>) -> ()
    return
  }
}

