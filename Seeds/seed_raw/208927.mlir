module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-173> : tensor<5x2x9x5xi64>}> : () -> tensor<5x2x9x5xi64>
    %1 = tosa.reverse %0 {axis = 0 : i32} : (tensor<5x2x9x5xi64>) -> tensor<5x2x9x5xi64>
    %cast = tensor.cast %1 : tensor<5x2x9x5xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

