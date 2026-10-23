module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-106> : tensor<9x5x7xi64>}> : () -> tensor<9x5x7xi64>
    %1 = "tosa.const"() <{values = dense<-6> : tensor<1x5x1xi64>}> : () -> tensor<1x5x1xi64>
    %2 = "tosa.const"() <{values = dense<-138> : tensor<5x6x4xi32>}> : () -> tensor<5x6x4xi32>
    %3 = "tosa.const"() <{values = dense<87> : tensor<1x6x1xi32>}> : () -> tensor<1x6x1xi32>
    %4 = tosa.sub %0, %1 : (tensor<9x5x7xi64>, tensor<1x5x1xi64>) -> tensor<9x5x7xi64>
    %5 = tosa.intdiv %2, %3 : (tensor<5x6x4xi32>, tensor<1x6x1xi32>) -> tensor<5x6x4xi32>
    %cast = tensor.cast %4 : tensor<9x5x7xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<5x6x4xi32> to tensor<*xi32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

