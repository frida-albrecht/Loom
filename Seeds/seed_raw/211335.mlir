module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<7xi1>}> : () -> tensor<7xi1>
    %1 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<7xi1>) -> tensor<1xi1>
    %2 = tosa.reduce_sum %1 {axis = 0 : i32} : (tensor<1xi1>) -> tensor<1xi1>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<1xi1>) -> tensor<1xi1>
    %4 = tosa.argmax %3 {axis = 0 : i32} : (tensor<1xi1>) -> tensor<i32>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

