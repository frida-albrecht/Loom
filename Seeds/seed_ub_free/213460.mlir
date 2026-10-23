module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<23> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const"() <{values = dense<-134> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %3 = tosa.bitwise_and %2, %2 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %4 = tosa.reduce_max %3 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %5 = tosa.identity %4 : (tensor<1xi32>) -> tensor<1xi32>
    %6 = tosa.add %5, %4 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %7 = tosa.argmax %6 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<i32>
    %8 = tosa.reduce_sum %3 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %9 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %10 = tosa.tile %6, %9 : (tensor<1xi32>, !tosa.shape<1>) -> tensor<1xi32>
    %cast = tensor.cast %7 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<1xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %10 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

