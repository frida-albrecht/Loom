module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-73> : tensor<1x3x6x3xi64>}> : () -> tensor<1x3x6x3xi64>
    %1 = "tosa.const"() <{values = dense<-163> : tensor<1x1x1x1xi64>}> : () -> tensor<1x1x1x1xi64>
    %2 = "tosa.const"() <{values = dense<1.872500e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.bitwise_and %0, %1 : (tensor<1x3x6x3xi64>, tensor<1x1x1x1xi64>) -> tensor<1x3x6x3xi64>
    %4 = tosa.clz %3 : (tensor<1x3x6x3xi64>) -> tensor<1x3x6x3xi64>
    %5 = tosa.ceil %2 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %4 : tensor<1x3x6x3xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

