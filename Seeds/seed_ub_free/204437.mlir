module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<46> : tensor<9x1xi64>}> : () -> tensor<9x1xi64>
    %1 = "tosa.const"() <{values = dense<52> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    %2 = tosa.minimum %0, %1 : (tensor<9x1xi64>, tensor<1x1xi64>) -> tensor<9x1xi64>
    %3 = tosa.reduce_sum %2 {axis = 0 : i32} : (tensor<9x1xi64>) -> tensor<1x1xi64>
    %cast = tensor.cast %3 : tensor<1x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

