module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-67> : tensor<4x10x7xi32>}> : () -> tensor<4x10x7xi32>
    %1 = "tosa.const"() <{values = dense<-189> : tensor<4x1x1xi32>}> : () -> tensor<4x1x1xi32>
    %2 = "tosa.const"() <{values = dense<-1.628800e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = tosa.minimum %0, %1 : (tensor<4x10x7xi32>, tensor<4x1x1xi32>) -> tensor<4x10x7xi32>
    %4 = tosa.ceil %2 : (tensor<1xf32>) -> tensor<1xf32>
    %5 = tosa.log %4 : (tensor<1xf32>) -> tensor<1xf32>
    %6 = tosa.reduce_max %5 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<1xf32>
    %7 = tosa.minimum %6, %6 : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %8 = tosa.tanh %7 : (tensor<1xf32>) -> tensor<1xf32>
    %9 = tosa.floor %4 : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %3 : tensor<4x10x7xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<1xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %9 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

