module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.941000e+01> : tensor<7x3xf32>}> : () -> tensor<7x3xf32>
    %1 = "tosa.const"() <{values = dense<-131> : tensor<9x2xi32>}> : () -> tensor<9x2xi32>
    %2 = "tosa.const"() <{values = dense<-118> : tensor<1x1xi32>}> : () -> tensor<1x1xi32>
    %3 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<7x3xf32>) -> tensor<1x3xf32>
    %4 = tosa.reduce_max %3 {axis = 1 : i32} : (tensor<1x3xf32>) -> tensor<1x1xf32>
    %5 = tosa.bitwise_or %1, %2 : (tensor<9x2xi32>, tensor<1x1xi32>) -> tensor<9x2xi32>
    %cast = tensor.cast %4 : tensor<1x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<9x2xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

