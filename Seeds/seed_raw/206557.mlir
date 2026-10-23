module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-71> : tensor<3xi64>}> : () -> tensor<3xi64>
    %1 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<3xi64>) -> tensor<1xi64>
    %cast = tensor.cast %1 : tensor<1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

