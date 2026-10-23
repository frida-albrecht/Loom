module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.162000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-81> : tensor<2xi64>}> : () -> tensor<2xi64>
    %2 = tosa.ceil %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.identity %2 : (tensor<f32>) -> tensor<f32>
    %4 = tosa.bitwise_not %1 : (tensor<2xi64>) -> tensor<2xi64>
    %5 = tosa.abs %4 : (tensor<2xi64>) -> tensor<2xi64>
    %cast = tensor.cast %3 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<2xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

