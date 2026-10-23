module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.813000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-106> : tensor<3x2x9x2xi64>}> : () -> tensor<3x2x9x2xi64>
    %2 = "tosa.const"() <{values = dense<166> : tensor<1x2x9x2xi64>}> : () -> tensor<1x2x9x2xi64>
    %3 = tosa.rsqrt %0 : (tensor<f32>) -> tensor<f32>
    %4 = tosa.bitwise_xor %1, %2 : (tensor<3x2x9x2xi64>, tensor<1x2x9x2xi64>) -> tensor<3x2x9x2xi64>
    %5 = tosa.clz %4 : (tensor<3x2x9x2xi64>) -> tensor<3x2x9x2xi64>
    %cast = tensor.cast %3 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<3x2x9x2xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

