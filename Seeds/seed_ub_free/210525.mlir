module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.088000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<-5> : tensor<7xi64>}> : () -> tensor<7xi64>
    %2 = "tosa.const"() <{values = dense<-154> : tensor<1xi64>}> : () -> tensor<1xi64>
    %3 = tosa.reciprocal %0 : (tensor<1xf32>) -> tensor<1xf32>
    %a1 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %a2 = "tosa.const"() <{values = dense<63> : tensor<1xi64>}> : () -> tensor<1xi64>
    %a3 = tosa.maximum %2, %a1 : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %a4 = tosa.minimum %a3, %a2 : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %4 = tosa.logical_left_shift %1, %a4 : (tensor<7xi64>, tensor<1xi64>) -> tensor<7xi64>
    %cast = tensor.cast %3 : tensor<1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<7xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}