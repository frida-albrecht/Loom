module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<128> : tensor<2xi64>}> : () -> tensor<2xi64>
    %1 = "tosa.const"() <{values = dense<-4.302000e+01> : tensor<8x10x7x4xf32>}> : () -> tensor<8x10x7x4xf32>
    %2 = "tosa.const"() <{values = dense<1.070900e+02> : tensor<1x1x1x1xf32>}> : () -> tensor<1x1x1x1xf32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %5 = tosa.negate %0, %3, %4 : (tensor<2xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<2xi64>
    %6 = tosa.pow %1, %2 : (tensor<8x10x7x4xf32>, tensor<1x1x1x1xf32>) -> tensor<8x10x7x4xf32>
    %7 = tosa.add %6, %6 : (tensor<8x10x7x4xf32>, tensor<8x10x7x4xf32>) -> tensor<8x10x7x4xf32>
    %cast = tensor.cast %5 : tensor<2xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %7 : tensor<8x10x7x4xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

