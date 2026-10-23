module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2.542000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<1.761500e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<84> : tensor<5x10xi64>}> : () -> tensor<5x10xi64>
    %3 = "tosa.const"() <{values = dense<89> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    %4 = tosa.pow %0, %1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %5 = tosa.maximum %2, %3 : (tensor<5x10xi64>, tensor<1x1xi64>) -> tensor<5x10xi64>
    %6 = tosa.reduce_max %5 {axis = 0 : i32} : (tensor<5x10xi64>) -> tensor<1x10xi64>
    %7 = tosa.arithmetic_right_shift %6, %6 {round = false} : (tensor<1x10xi64>, tensor<1x10xi64>) -> tensor<1x10xi64>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<1x10xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

