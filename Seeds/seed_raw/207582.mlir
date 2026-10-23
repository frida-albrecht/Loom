module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-75> : tensor<2xi32>}> : () -> tensor<2xi32>
    %1 = "tosa.const"() <{values = dense<138> : tensor<2xi32>}> : () -> tensor<2xi32>
    %2 = "tosa.const"() <{values = dense<-1.114900e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.intdiv %0, %1 : (tensor<2xi32>, tensor<2xi32>) -> tensor<2xi32>
    %4 = tosa.argmax %3 {axis = 0 : i32} : (tensor<2xi32>) -> tensor<i32>
    %5 = tosa.ceil %2 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.reduce_max %3 {axis = 0 : i32} : (tensor<2xi32>) -> tensor<1xi32>
    %7 = tosa.maximum %6, %6 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    %cast_1 = tensor.cast %7 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

