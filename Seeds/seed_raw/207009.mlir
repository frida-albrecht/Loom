module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-182> : tensor<9x5x6xi64>}> : () -> tensor<9x5x6xi64>
    %1 = "tosa.const"() <{values = dense<70> : tensor<9x6x2xi64>}> : () -> tensor<9x6x2xi64>
    %2 = "tosa.const"() <{values = dense<6.669000e+01> : tensor<6x3x2xf32>}> : () -> tensor<6x3x2xf32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<9x5x6xi64>, tensor<9x6x2xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<9x5x2xi64>
    %6 = tosa.ceil %2 : (tensor<6x3x2xf32>) -> tensor<6x3x2xf32>
    %cast = tensor.cast %5 : tensor<9x5x2xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %6 : tensor<6x3x2xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

