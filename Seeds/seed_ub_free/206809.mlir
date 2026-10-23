module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-192> : tensor<9x9x6xi64>}> : () -> tensor<9x9x6xi64>
    %1 = "tosa.const"() <{values = dense<40> : tensor<9x6x1xi64>}> : () -> tensor<9x6x1xi64>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<9x9x6xi64>, tensor<9x6x1xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<9x9x1xi64>
    %5 = tosa.add %4, %4 : (tensor<9x9x1xi64>, tensor<9x9x1xi64>) -> tensor<9x9x1xi64>
    %cast = tensor.cast %5 : tensor<9x9x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

