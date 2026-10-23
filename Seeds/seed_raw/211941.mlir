module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-110> : tensor<4x4x3xi64>}> : () -> tensor<4x4x3xi64>
    %1 = "tosa.const"() <{values = dense<200> : tensor<4x3x9xi64>}> : () -> tensor<4x3x9xi64>
    %2 = "tosa.const"() <{values = dense<-2.728000e+01> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<4x4x3xi64>, tensor<4x3x9xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<4x4x9xi64>
    %6 = tosa.tanh %2 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %5 : tensor<4x4x9xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %6 : tensor<f32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

