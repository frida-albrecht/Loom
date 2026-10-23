module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<81> : tensor<10xi32>}> : () -> tensor<10xi32>
    %1 = "tosa.const"() <{values = dense<-6.297000e+01> : tensor<9x1x5x8xf32>}> : () -> tensor<9x1x5x8xf32>
    %2 = tosa.argmax %0 {axis = 0 : i32} : (tensor<10xi32>) -> tensor<i32>
    %3 = tosa.tanh %1 : (tensor<9x1x5x8xf32>) -> tensor<9x1x5x8xf32>
    %4 = tosa.abs %2 : (tensor<i32>) -> tensor<i32>
    %5 = tosa.identity %4 : (tensor<i32>) -> tensor<i32>
    %6 = tosa.reduce_sum %3 {axis = 2 : i32} : (tensor<9x1x5x8xf32>) -> tensor<9x1x1x8xf32>
    %cast = tensor.cast %5 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<9x1x1x8xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

