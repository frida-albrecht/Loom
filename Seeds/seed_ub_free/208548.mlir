module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-63> : tensor<8xi64>}> : () -> tensor<8xi64>
    %1 = "tosa.const"() <{values = dense<-119> : tensor<1xi64>}> : () -> tensor<1xi64>
    %2 = "tosa.const"() <{values = dense<3.890000e+00> : tensor<f32>}> : () -> tensor<f32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %clamped_lower = tosa.maximum %1, %c0 : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<1xi64>}> : () -> tensor<1xi64>
    %safe_shift = tosa.minimum %clamped_lower, %c63 : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %3 = tosa.arithmetic_right_shift %0, %safe_shift {round = false} : (tensor<8xi64>, tensor<1xi64>) -> tensor<8xi64>
    %4 = tosa.sigmoid %2 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %3 : tensor<8xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}