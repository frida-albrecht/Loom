module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2.542000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<1.761500e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<84> : tensor<5x10xi64>}> : () -> tensor<5x10xi64>
    %3 = "tosa.const"() <{values = dense<89> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    %f0 = "tosa.const"() <{values = dense<0.0> : tensor<f32>}> : () -> tensor<f32>
    %p0 = tosa.maximum %0, %f0 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %4 = tosa.pow %p0, %1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %5 = tosa.maximum %2, %3 : (tensor<5x10xi64>, tensor<1x1xi64>) -> tensor<5x10xi64>
    %6 = tosa.reduce_max %5 {axis = 0 : i32} : (tensor<5x10xi64>) -> tensor<1x10xi64>
    %i0 = "tosa.const"() <{values = dense<0> : tensor<1x10xi64>}> : () -> tensor<1x10xi64>
    %i1 = "tosa.const"() <{values = dense<63> : tensor<1x10xi64>}> : () -> tensor<1x10xi64>
    %s0 = tosa.maximum %6, %i0 : (tensor<1x10xi64>, tensor<1x10xi64>) -> tensor<1x10xi64>
    %s1 = tosa.minimum %s0, %i1 : (tensor<1x10xi64>, tensor<1x10xi64>) -> tensor<1x10xi64>
    %7 = tosa.arithmetic_right_shift %6, %s1 {round = false} : (tensor<1x10xi64>, tensor<1x10xi64>) -> tensor<1x10xi64>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<1x10xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}