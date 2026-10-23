module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-171> : tensor<1x8xi64>}> : () -> tensor<1x8xi64>
    %1 = "tosa.const"() <{values = dense<-53> : tensor<22x8xi64>}> : () -> tensor<22x8xi64>
    %2 = tosa.concat %0, %1 {axis = 0 : i32} : (tensor<1x8xi64>, tensor<22x8xi64>) -> tensor<23x8xi64>
    %cast = tensor.cast %2 : tensor<23x8xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

