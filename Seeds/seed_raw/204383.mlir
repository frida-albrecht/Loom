module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-46> : tensor<10x10x8xi64>}> : () -> tensor<10x10x8xi64>
    %1 = "tosa.const"() <{values = dense<-191> : tensor<10x8x1xi64>}> : () -> tensor<10x8x1xi64>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<10x10x8xi64>, tensor<10x8x1xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<10x10x1xi64>
    %5 = tosa.argmax %4 {axis = 0 : i32} : (tensor<10x10x1xi64>) -> tensor<10x1xi32>
    %6 = tosa.bitwise_and %5, %5 : (tensor<10x1xi32>, tensor<10x1xi32>) -> tensor<10x1xi32>
    %7 = tosa.intdiv %6, %6 : (tensor<10x1xi32>, tensor<10x1xi32>) -> tensor<10x1xi32>
    %cast = tensor.cast %7 : tensor<10x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

