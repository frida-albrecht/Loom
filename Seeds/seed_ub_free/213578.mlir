module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.433200e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-117> : tensor<3xi64>}> : () -> tensor<3xi64>
    %2 = tosa.tanh %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.reduce_max %1 {axis = 0 : i32} : (tensor<3xi64>) -> tensor<1xi64>
    %4 = tosa.tanh %2 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %3 : tensor<1xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

