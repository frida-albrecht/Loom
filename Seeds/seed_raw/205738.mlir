module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<142> : tensor<7xi16>}> : () -> tensor<7xi16>
    %1 = "tosa.const"() <{values = dense<-110> : tensor<7x5x9x8xi32>}> : () -> tensor<7x5x9x8xi32>
    %2 = "tosa.const"() <{values = dense<101> : tensor<7x5x1x8xi32>}> : () -> tensor<7x5x1x8xi32>
    %3 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<7xi16>) -> tensor<1xi16>
    %4 = tosa.intdiv %1, %2 : (tensor<7x5x9x8xi32>, tensor<7x5x1x8xi32>) -> tensor<7x5x9x8xi32>
    %5 = tosa.argmax %3 {axis = 0 : i32} : (tensor<1xi16>) -> tensor<i32>
    %cast = tensor.cast %4 : tensor<7x5x9x8xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

