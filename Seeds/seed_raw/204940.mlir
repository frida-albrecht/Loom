module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<18> : tensor<7xi64>}> : () -> tensor<7xi64>
    %1 = "tosa.const"() <{values = dense<-9.013000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.const_shape  {values = dense<3> : tensor<1xindex>} : () -> !tosa.shape<1>
    %3 = tosa.tile %0, %2 : (tensor<7xi64>, !tosa.shape<1>) -> tensor<21xi64>
    %4 = tosa.reduce_max %3 {axis = 0 : i32} : (tensor<21xi64>) -> tensor<1xi64>
    %5 = tosa.sigmoid %1 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %4 : tensor<1xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

