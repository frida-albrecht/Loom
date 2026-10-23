module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.780000e+01> : tensor<2xf32>}> : () -> tensor<2xf32>
    %1 = "tosa.const"() <{values = dense<9.298000e+01> : tensor<2xf32>}> : () -> tensor<2xf32>
    %2 = "tosa.const"() <{values = dense<-111> : tensor<1x8x2x5xi64>}> : () -> tensor<1x8x2x5xi64>
    %3 = "tosa.const"() <{values = dense<-103> : tensor<1x1x2x1xi64>}> : () -> tensor<1x1x2x1xi64>
    %4 = tosa.pow %0, %1 : (tensor<2xf32>, tensor<2xf32>) -> tensor<2xf32>
    %5 = tosa.sigmoid %4 : (tensor<2xf32>) -> tensor<2xf32>
    %6 = tosa.bitwise_xor %2, %3 : (tensor<1x8x2x5xi64>, tensor<1x1x2x1xi64>) -> tensor<1x8x2x5xi64>
    %cast = tensor.cast %5 : tensor<2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<1x8x2x5xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

