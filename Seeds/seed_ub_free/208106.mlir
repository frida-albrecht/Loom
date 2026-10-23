module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<95.5299987> : tensor<7x7x5x8xf32>}> : () -> tensor<7x7x5x8xf32>
    %1 = "tosa.const"() <{values = dense<-129> : tensor<4xi32>}> : () -> tensor<4xi32>
    %2 = tosa.log %0 : (tensor<7x7x5x8xf32>) -> tensor<7x7x5x8xf32>
    %3 = tosa.bitwise_not %1 : (tensor<4xi32>) -> tensor<4xi32>
    %4 = tosa.reduce_max %3 {axis = 0 : i32} : (tensor<4xi32>) -> tensor<1xi32>
    %5 = tosa.reduce_min %4 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %2 : tensor<7x7x5x8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

