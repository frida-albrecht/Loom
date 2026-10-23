module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-114> : tensor<7xi32>}> : () -> tensor<7xi32>
    %1 = "tosa.const"() <{values = dense<147> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = "tosa.const"() <{values = dense<-1.987400e+02> : tensor<5x3x9x3xf32>}> : () -> tensor<5x3x9x3xf32>
    %3 = tosa.minimum %0, %1 : (tensor<7xi32>, tensor<1xi32>) -> tensor<7xi32>
    %4 = tosa.reciprocal %2 : (tensor<5x3x9x3xf32>) -> tensor<5x3x9x3xf32>
    %5 = tosa.reduce_max %3 {axis = 0 : i32} : (tensor<7xi32>) -> tensor<1xi32>
    %6 = tosa.bitwise_or %5, %5 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %7 = tosa.identity %6 : (tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %4 : tensor<5x3x9x3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

