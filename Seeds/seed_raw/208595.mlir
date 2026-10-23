module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.231000e+01> : tensor<4xf32>}> : () -> tensor<4xf32>
    %1 = "tosa.const"() <{values = dense<104> : tensor<7x6x6x7xi64>}> : () -> tensor<7x6x6x7xi64>
    %2 = "tosa.const"() <{values = dense<-41> : tensor<7x1x1x7xi64>}> : () -> tensor<7x1x1x7xi64>
    %3 = tosa.ceil %0 : (tensor<4xf32>) -> tensor<4xf32>
    %4 = tosa.bitwise_xor %1, %2 : (tensor<7x6x6x7xi64>, tensor<7x1x1x7xi64>) -> tensor<7x6x6x7xi64>
    %cast = tensor.cast %3 : tensor<4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<7x6x6x7xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

