module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<13> : tensor<3x4x9x9xi64>}> : () -> tensor<3x4x9x9xi64>
    %1 = "tosa.const"() <{values = dense<-13> : tensor<1x1x1x1xi64>}> : () -> tensor<1x1x1x1xi64>
    %2 = tosa.minimum %0, %1 : (tensor<3x4x9x9xi64>, tensor<1x1x1x1xi64>) -> tensor<3x4x9x9xi64>
    %cast = tensor.cast %2 : tensor<3x4x9x9xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

