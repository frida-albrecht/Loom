module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.856900e+02> : tensor<3xf32>}> : () -> tensor<3xf32>
    %1 = "tosa.const"() <{values = dense<-198> : tensor<10x4xi32>}> : () -> tensor<10x4xi32>
    %2 = "tosa.const"() <{values = dense<-68> : tensor<10x1xi32>}> : () -> tensor<10x1xi32>
    %3 = tosa.tanh %0 : (tensor<3xf32>) -> tensor<3xf32>
    %4 = tosa.intdiv %1, %2 : (tensor<10x4xi32>, tensor<10x1xi32>) -> tensor<10x4xi32>
    %5 = tosa.reduce_max %3 {axis = 0 : i32} : (tensor<3xf32>) -> tensor<1xf32>
    %cast = tensor.cast %4 : tensor<10x4xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

