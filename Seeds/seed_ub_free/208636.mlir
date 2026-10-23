module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-54> : tensor<6x1x7x5xi64>}> : () -> tensor<6x1x7x5xi64>
    %1 = tosa.reverse %0 {axis = 3 : i32} : (tensor<6x1x7x5xi64>) -> tensor<6x1x7x5xi64>
    %2 = tosa.reverse %1 {axis = 0 : i32} : (tensor<6x1x7x5xi64>) -> tensor<6x1x7x5xi64>
    %cast = tensor.cast %2 : tensor<6x1x7x5xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

