module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<2xi1>}> : () -> tensor<2xi1>
    %1 = "tosa.const"() <{values = dense<-134> : tensor<2x10xi64>}> : () -> tensor<2x10xi64>
    %2 = tosa.argmax %0 {axis = 0 : i32} : (tensor<2xi1>) -> tensor<i32>
    %3 = tosa.reduce_min %1 {axis = 1 : i32} : (tensor<2x10xi64>) -> tensor<2x1xi64>
    %cast = tensor.cast %2 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %3 : tensor<2x1xi64> to tensor<*xi64>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

