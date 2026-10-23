module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.372100e+02> : tensor<3x4xf32>}> : () -> tensor<3x4xf32>
    %1 = "tosa.const"() <{values = dense<-103> : tensor<2x9x10x9xi64>}> : () -> tensor<2x9x10x9xi64>
    %2 = "tosa.const"() <{values = dense<-30> : tensor<1x1x1x9xi64>}> : () -> tensor<1x1x1x9xi64>
    %3 = tosa.tanh %0 : (tensor<3x4xf32>) -> tensor<3x4xf32>
    %f0 = "tosa.const"() <{values = dense<0> : tensor<1x1x1x9xi64>}> : () -> tensor<1x1x1x9xi64>
    %clamped_lower = tosa.maximum %2, %f0 : (tensor<1x1x1x9xi64>, tensor<1x1x1x9xi64>) -> tensor<1x1x1x9xi64>
    %f1 = "tosa.const"() <{values = dense<63> : tensor<1x1x1x9xi64>}> : () -> tensor<1x1x1x9xi64>
    %clamped_shift = tosa.minimum %clamped_lower, %f1 : (tensor<1x1x1x9xi64>, tensor<1x1x1x9xi64>) -> tensor<1x1x1x9xi64>
    %4 = tosa.logical_left_shift %1, %clamped_shift : (tensor<2x9x10x9xi64>, tensor<1x1x1x9xi64>) -> tensor<2x9x10x9xi64>
    %5 = tosa.identity %3 : (tensor<3x4xf32>) -> tensor<3x4xf32>
    %cast = tensor.cast %4 : tensor<2x9x10x9xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<3x4xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}