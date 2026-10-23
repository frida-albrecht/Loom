module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-41> : tensor<9x3x2xi64>}> : () -> tensor<9x3x2xi64>
    %1 = "tosa.const"() <{values = dense<-126> : tensor<9x1x2xi64>}> : () -> tensor<9x1x2xi64>
    %2 = "tosa.const"() <{values = dense<-82.6699981> : tensor<8x6xf32>}> : () -> tensor<8x6xf32>
    %3 = "tosa.const"() <{values = dense<1.563300e+02> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %4 = tosa.logical_left_shift %0, %1 : (tensor<9x3x2xi64>, tensor<9x1x2xi64>) -> tensor<9x3x2xi64>
    %5 = tosa.pow %2, %3 : (tensor<8x6xf32>, tensor<1x1xf32>) -> tensor<8x6xf32>
    %6 = tosa.exp %5 : (tensor<8x6xf32>) -> tensor<8x6xf32>
    %cast = tensor.cast %4 : tensor<9x3x2xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %6 : tensor<8x6xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

